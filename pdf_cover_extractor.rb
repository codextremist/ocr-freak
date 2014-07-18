class PDFCoverExtractor

  def self.extract(pdf, first_page:1, last_page:1)
     puts "Extraindo capa de #{pdf}"
     puts "pdfimages -f #{first_page} -l #{last_page} -j #{pdf} #{OCRFreak::DATA_PATH}/#{File.basename(pdf, '.rb')}_capa"
     `pdfimages -f #{first_page} -l #{last_page} -j #{pdf} #{OCRFreak::DATA_PATH}/#{File.basename(pdf, '.rb')}_capa`
  end
end
