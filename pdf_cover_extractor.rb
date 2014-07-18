class PDFCoverExtractor

  def self.extract(pdf, first_page:1, last_page:1)
     output_file = File.join(OCRFreak::OUTPUT_PATH, File.basename(pdf, '.pdf'))
     puts "Extraindo capa de #{pdf}"
     puts "pdfimages -f #{first_page} -l #{last_page} -j #{pdf} #{output_file}_capa"
     `pdfimages -f #{first_page} -l #{last_page} -j #{pdf} #{output_file}_capa`
     file_pattern = "#{output_file}_capa*"
     file = Dir.glob(file_pattern).first
     image = Magick::Image.read(file).first
     image = image.resize_to_fit(461,614)
     image.write("#{output_file}_capa_optimized.jpg")
  end
end
