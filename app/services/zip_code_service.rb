class ZipCodeService
  def initialize(zip_code)
    @zip_code = zip_code
  end

  def verify
    input_present
    valid_characters
    valid_length
  end

  private

  def input_present
    raise Errors::NotPresent if @zip_code.blank?
  end

  def valid_characters
    # Use regex to check if any non-digit char is present
    raise Errors::InvalidCharacters if @zip_code.scan(/\D/).present?
  end

  def valid_length
    # Valid zip code length is between 3 and 5 digits
    raise Errors::InvalidLength unless @zip_code.length >= 3 && @zip_code.length <= 5
  end

  class Errors
    # check for a blank string
    class NotPresent < StandardError
      def message
        'No input to search by. Please enter a valid Zip Code.'
      end
    end

    class InvalidCharacters < StandardError
      # Check for bad characters in string
      def message
        'Bad characters found in the input. Please input digits only'
      end
    end

    class InvalidLength < StandardError
      # Check wrong number of digits in string
      def message
        'Zip code is an invalid length.'
      end
    end
  end
end
