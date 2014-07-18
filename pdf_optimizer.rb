class PDFOptimizer

  def self.optimize(pdf, device: 'pdfwrite', pdf_settings: '/screen')
     puts "Otimizando #{pdf}"
     puts "gs -sDEVICE=#{device} -dPDFSETTINGS=#{pdf_settings} -o #{OCRFreak::DATA_PATH}/#{File.basename(pdf)}_optimized.pdf #{pdf}"
    `gs -sDEVICE=#{device} -dPDFSETTINGS=#{pdf_settings} -o #{OCRFreak::DATA_PATH}/#{File.basename(pdf, '.pdf')}_optimized.pdf #{pdf}`
  end


end
