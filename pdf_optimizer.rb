class PDFOptimizer

  def self.optimize(pdf, device: 'pdfwrite', pdf_settings: '/screen')
     output_file = File.join(OCRFreak::OUTPUT_PATH, File.basename(pdf, '.pdf'))
     puts "Otimizando #{pdf}"
     puts "gs -sDEVICE=#{device} -dPDFSETTINGS=#{pdf_settings} -o #{output_file}_optimized.pdf #{pdf}"
    `gs -sDEVICE=#{device} -dPDFSETTINGS=#{pdf_settings} -o #{output_file}_optimized.pdf #{pdf}`
  end


end
