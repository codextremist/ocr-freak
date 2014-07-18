class OCRProcessor
    
  BASENAME_PATTERN = /\/?(\w*).pdf/
  TMP_FILES = File.join(OCRFreak::INPUT_PATH, "*.tiff")

  def initialize
    @engine = Tesseract::Engine.new do |engine|
      engine.path = '/usr/share/tesseract-ocr/tessdata/'
      engine.language = "por"
    end
  end

  def store_ocr_data(file)
    ocr_file = "#{OCRFreak::OUTPUT_PATH}/#{file_basename(file)}_ocr.txt"   
    File.open(ocr_file, "wb") do |f|
      f.puts process(file)
    end
    puts "Saving OCR to #{ocr_file}"
  end
  
  def remove_tmp_files
    puts "Removing temporary files"
    Dir.glob(TMP_FILES).each do |f|
      File.delete(f)
    end
  end

  protected
  
  def process(file)
    generate_tmp_files_for(file).sort do |a,b|
      a.match(/([0-9]*)_/).captures.first.to_i <=> b.match(/([0-9]*)_/).captures.first.to_i
    end.map do |f|
      puts "OCR for #{f}"
      @engine.text_for(f)
    end.join
  end
  
  private

  def file_basename(file)
    file.match(BASENAME_PATTERN).captures.first
  end

  def generate_tmp_files_for(file)
    puts "Generating tiff files for #{file}"
    rmagick = Magick::Image.read(file){ |f| f.density = 300 }
    rmagick.each_with_index do |page, index|
      if index > 1
        page.alpha = Magick::DeactivateAlphaChannel
        page.write(File.join(OCRFreak::OUTPUT_PATH,"#{index}_#{file_basename(file)}.tiff")){|f| f.depth = 8 }
      end
    end
    Dir.glob(TMP_FILES)
  end    

end
