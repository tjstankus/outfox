module Outfox
  module Receivers
    class WachoviaCheckingStatement
      
      def initialize
        @lines = []
      end
      
      def set_text_matrix_and_text_line_matrix(a,b,c,d,e,y_axis)
        create_new_line_for_text unless y_axis == @current_line_number
        @current_line_number = y_axis
      end

      def create_new_line_for_text
        @lines << @current_line = []
      end

      def show_text(text)
        @current_line << text
      end

      def account_number
        @lines.each do |line|
          return line[2] if line[0] == 'Account' && line[1] == 'number:'
        end
      end
    end
  end
end