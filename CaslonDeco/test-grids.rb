#!/usr/bin/env ruby

require 'fileutils'

output_dir = "pdf"
FileUtils.mkdir_p(output_dir)

# LaTeX boilerplate
preamble = <<~LATEX
  \\documentclass{standalone}
  \\usepackage{xcolor}
  \\usepackage{caslondeco}
  \\begin{document}
  \\begin{tikzpicture}[x=12pt,y=12pt]
  \\def\\cardWidth{3.5in}
  \\def\\cardHeight{2.0in}
  \\draw[black!20, line width=1pt] (0,0) rectangle (\\cardWidth,\\cardHeight);
  \\clip (0,0) rectangle (\\cardWidth,\\cardHeight);
LATEX

postamble = <<~LATEX
  \\end{tikzpicture}
  \\end{document}
LATEX

# Default parameter values
defaults = {
  Nx: 21,
  Ny: 12,
  displaywidth: "3.5in",
  displayheight: "2in",
  #modval: 0,
  #xshift: 0.0,
  yshift: 0.5,
  color: "black!40!white",
  #flrmodval: 0
}

# Only differences from defaults need to be listed
grids = [
  # plain grid
  { },
  # alternate x's
  { modval: 1 },
  { modval: 2 },
  { modval: 3, xshift: 2.0 },
  { modval: 4 },
  # alternate fleurons
  { flrmodval: 1, modval: 1 },
  { flrmodval: 1 },
  { flrmodval: 2, xshift: 1.0 },
  { flrmodval: 3, xshift: 3.0 },
  { flrmodval: 3, xshift: 6.0 },
  { flrmodval: 4, xshift: 1.0 },
  # with initials
  { flrmodval: 2, xshift: 1.0, initial: '{b}' },
  { flrmodval: 4, xshift: 1.0, initial: '{\\footnotesize \\textsw{A}}' },
]

def latex_drawxgrid(params)
  lines = params.map do |key, value|
    val = value.is_a?(Numeric) ? value : value.to_s
    "  #{key}=#{val},%"
  end
  "\\drawxgrid{%\n" + lines.join("\n") + "\n}"
end

grids.each_with_index do |overrides, i|
  full_params = defaults.merge(overrides)
  basename = "grid_#{i.to_s.rjust(2, '0')}"
  tex_filename = "#{basename}.tex"
  pdf_filename = "#{basename}.pdf"

  latex_code = preamble + "\n" + latex_drawxgrid(full_params) + "\n" + postamble
  File.write(tex_filename, latex_code)

  puts "Compiling #{tex_filename}..."
  system("pdflatex -halt-on-error -interaction=nonstopmode #{tex_filename}")

  if File.exist?(pdf_filename)
    FileUtils.mv(pdf_filename, File.join(output_dir, pdf_filename))
  else
    puts "Failed to compile #{tex_filename}"
  end

  %w[aux log].each { |ext| File.delete("#{basename}.#{ext}") if File.exist?("#{basename}.#{ext}") }
  File.delete(tex_filename)
end

puts "Done! PDFs saved to ./#{output_dir}/"
