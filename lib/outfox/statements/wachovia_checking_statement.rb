module Outfox
  module Statements
    class WachoviaCheckingStatement < Statement

      attr_reader :lines

      def initialize
        @lines = []
        @transactions = []
      end

      ##########################################################################
      # pdf-reader callbacks
      #
      def set_text_matrix_and_text_line_matrix(a,b,c,d,e,y_axis)
        create_new_line_for_text unless y_axis == @current_line_number
        @current_line_number = y_axis
      end

      def show_text(text)
        @current_line << text
      end
      #
      # end pdf-reader callbacks
      ##########################################################################

      def create_new_line_for_text
        lines << @current_line = []
      end

      def bank_routing_number
        '053000219'
      end

      def account_type
        'checking'
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

      def start_of_transaction?(line)
        line[0].include?('/') && starts_with_month?(line[0])
      end

      def starts_with_month?(text)
        raise "Invalid parameter, must include '/'" unless text.include?('/')
        (1..12).include?(text[0, text.index('/')].to_i)
      end
      
      def year_for_month(month)
        return @start_date.year if @start_date.year == @end_date.year
      end
      
      def transactions
        @transactions.empty? ? parse_transactions : @transactions
      end
      
      def parse_transactions
        parse_deposits
        @transactions
      end

      def parse_deposits
        lines.each_with_index do |line, i|
          @first_deposit_line_idx = next_transaction_index(i) if begin_deposit_block?(line)
          @last_deposit_line_idx = i - 1 if end_deposit_block?(line)
          break if @first_deposit_line_idx && @last_deposit_line_idx
        end
        parse_transactions_lines((@first_deposit_line_idx..@last_deposit_line_idx), :credit)
      end
      
      def parse_transactions_lines(line_indexes, txn_type)
        line_indexes.each do |i|
          if start_of_transaction?(lines[i])
            @transactions << Outfox::Statements::Transaction.new(self, @txn_data, txn_type) if @txn_data
            @txn_data = lines[i]
          else
            @txn_data += lines[i]
          end
          @transactions << Outfox::Statements::Transaction.new(self, @txn_data, txn_type) if line_indexes.last == i
        end
      end
      
      def next_transaction_index(index)
        index += 1
        until start_of_transaction?(lines[index])
          index += 1
        end
        index
      end
      
      def prev_transaction_index(index)
        index -= 1
        until start_of_transaction?(lines[index])
          index -= 1
        end
        index
      end
      
      def begin_deposit_block?(line)
        line.collect(&:downcase) == ["deposits", "and", "other", "credits"] &&
            lines[lines.index(line) + 1].collect(&:downcase) == ["date", "amount", "description"]
      end
      
      def end_deposit_block?(line)
        line[0] == 'Total'
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