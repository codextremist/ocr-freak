#!/usr/bin/env ruby
# encoding: utf-8
ocr_freak_path = File.dirname(__FILE__)
$LOAD_PATH.unshift(ocr_freak_path) unless $LOAD_PATH.include?(ocr_freak_path)

require 'tesseract-ocr'
require 'RMagick'
require 'ruby-progressbar'
require 'debugger'

module OCRFreak
  
  INPUT_PATH = File.join(File.dirname(__FILE__),"input")
  OUTPUT_PATH = File.join(File.dirname(__FILE__),"output")

  autoload :OCRProcessor, 'ocr_processor'
  autoload :PDFCoverExtractor, 'pdf_cover_extractor'
  autoload :PDFOptimizer, 'pdf_optimizer'

  def self.run
    ocr_processor = OCRProcessor.new
    inputs.each do |pdf|
      PDFOptimizer.optimize(pdf)
      PDFCoverExtractor.extract(pdf)
      ocr_processor.remove_tmp_files
      ocr_processor.store_ocr_data(pdf)
      puts "\n============================================================================\n"
    end
  end

  def self.inputs
    Dir.glob(File.join(INPUT_PATH, "*.pdf"))
  end

end

OCRFreak.run
