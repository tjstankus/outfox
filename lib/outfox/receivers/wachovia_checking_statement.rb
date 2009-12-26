module Outfox
  module Receivers
    class WachoviaCheckingStatement < Statement
      
      attr_reader :lines
      
      def initialize
        @lines = []
      end
      
      def bank_routing_number
        '053000219'
      end
      
      def account_type
        'checking'
      end
      
      def set_text_matrix_and_text_line_matrix(a,b,c,d,e,y_axis)
        create_new_line_for_text unless y_axis == @current_line_number
        @current_line_number = y_axis
      end

      def create_new_line_for_text
        lines << @current_line = []
      end

      def show_text(text)
        @current_line << text
      end

      def account_number
        lines.each do |line|
          return line[2] if line[0] == 'Account' && line[1] == 'number:'
        end
      end
      
      def start_date
        @start_date || start_and_end_dates[0]
      end
      
      def end_date
        @end_date || start_and_end_dates[1]
      end
      
      private
      
      def start_and_end_dates
        unless @start_date && @end_date
          lines.each do |line|
            if idx = line.index('thru')
              @start_date = DateTime.parse(line[idx - 1])
              @end_date = DateTime.parse(line[idx + 1])
              break
            end
          end
          [@start_date, @end_date]
        end
      end
      
    end
  end
end