#!/usr/bin/env ruby

require 'fileutils'

output_dir = "pdf"
FileUtils.mkdir_p(output_dir)

# LaTeX preamble (including custom colors)
preamble = <<~LATEX
  \\documentclass{standalone}
  \\usepackage{xcolor}
  \\usepackage{tikz}
  \\usepackage{caslondeco}

  \\definecolor{cornflowerblue}{HTML}{9ACEEB}
  \\definecolor{cambridgeblue}{HTML}{839788}
  \\definecolor{resedagreen}{HTML}{73877B}
  \\definecolor{silver}{HTML}{BDBBB6}
  \\definecolor{rose}{HTML}{E5D1D0}
  \\definecolor{paledogwood}{HTML}{DDC2C0}

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

# List of tile test cases (only specify what's different)
tile_tests = [
  {
    tileA: "\\mdbia", colorA: "silver",
    tileB: "\\mdbb",  colorB: "paledogwood",
    tileC: "\\mdba",  colorC: "resedagreen",
    tileD: "\\mdba",  colorD: "cambridgeblue"
  },
  {
    tileA: "\\mdbie", colorA: "silver",
    tileB: "\\mdbie", colorB: "silver",
    tileC: "\\mdbe",  colorC: "black!30!silver",
    tileD: "\\mdbe",  colorD: "black!30!silver"
  },
  {
    tileA: "\\mdbb",  colorA: "silver",
    tileB: "\\mdbia", colorB: "silver",
    tileC: "\\mdbd",  colorC: "resedagreen",
    tileD: "\\mdbd",  colorD: "resedagreen"
  },
  {
    tileA: "\\mdba",  colorA: "silver",
    tileB: "\\mdbia", colorB: "silver",
    tileC: "\\mdbb",  colorC: "silver",
    tileD: "\\mdbib", colorD: "silver"
  },
  {
    tileA: "\\mdbhx", colorA: "silver",
    tileB: "\\mdbihx",colorB: "silver",
    tileC: "\\mdbb",  colorC: "silver",
    tileD: "\\mdbib", colorD: "silver"
  },
  {
    tileA: "\\mdbc",  colorA: "silver",
    tileB: "\\mdbic", colorB: "silver",
    tileC: "\\mdbd",  colorC: "silver",
    tileD: "\\mdbid", colorD: "silver"
  }
]

# Default parameters for all tiles
tile_defaults = {
  Nx: 9, Ny: 5,
  displaywidth: "3.5in",
  displayheight: "2in"
}

def latex_drawtilepattern(params)
  lines = params.map do |key, value|
    val = value.is_a?(Numeric) ? value : value.to_s
    "  #{key}=#{val},%"
  end
  "\\drawtilepattern{%\n" + lines.join("\n") + "\n}"
end

tile_tests.each_with_index do |overrides, i|
  full_params = tile_defaults.merge(overrides)
  basename = "tile_#{i.to_s.rjust(2, '0')}"
  tex_filename = "#{basename}.tex"
  pdf_filename = "#{basename}.pdf"

  latex_code = preamble + "\n" + latex_drawtilepattern(full_params) + "\n" + postamble
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
