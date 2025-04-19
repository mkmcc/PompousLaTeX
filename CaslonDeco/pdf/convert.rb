require 'fileutils'

# Desired output: 400 px wide from 3.5 inch PDFs
res = (800.0 / 3.5).round(2)

# Output directory
out_dir = "../png"
Dir.mkdir(out_dir) unless Dir.exist?(out_dir)

# Find all PDF files in the current directory
files = Dir.glob("*.pdf")

files.each do |file|
  base = File.basename(file, ".pdf")
  tmp_path = "#{base}.tmp.png"
  final_path = File.join(out_dir, "#{base}.png")

  # Step 1: Ghostscript with antialiasing
  gs_cmd = "gs -q -sDEVICE=pngalpha -dSAFER -dBATCH -dNOPAUSE " \
           "-r#{res} -sOutputFile='#{tmp_path}' '#{file}'"
  puts "Rendering #{file} -> #{tmp_path} at #{res} dpi"
  system(gs_cmd)

  # Step 2: Flatten transparency onto white using Ischemic
  im_cmd = "magick '#{tmp_path}' -background white -alpha remove -alpha off '#{final_path}'"
  puts "Flattening #{tmp_path} -> #{final_path}"
  system(im_cmd)

  FileUtils.rm_f(tmp_path)
end
