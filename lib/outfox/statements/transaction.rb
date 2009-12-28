module Outfox
  module Statements
    class Transaction

      attr_reader :statement, :data, :info_data, :txn_type

      TYPE_MAP = { 'COUNTER' => 'DEP',
                   'REFUND' => 'POS' }
      INFO_DATA_OFFSET = 2

      def initialize(statement, data, txn_type)
        @statement = statement
        @data = data
        @info_data = data[INFO_DATA_OFFSET, data.length-1]
        @txn_type = txn_type
      end

      def datetime_posted
        date_str = data.first
        month = date_str[0, date_str.index('/')].to_i
        year = statement.year_for_month(month)
        day = date_str[date_str.index('/') + 1, date_str.length].to_i
        DateTime.new(year, month, day)
      end

      def transaction_type
        txn_type_data = case txn_type
                        when :credit
                          @data[2].upcase
                        else
                          raise "Unknown transaction type"
                        end
        TYPE_MAP[txn_type_data]
      end

      def amount
        data[1].gsub(',','').insert(0, amount_operator)
      end

      def amount_operator
        txn_type == :credit ? '+' : '-'
      end
      
      def info_data_includes_date?
        !info_data_date_index.nil?
      end
      
      def info_data_date_index
        info_data.each_with_index do |item, i|
          date = Date.parse(item) rescue nil
          return i + INFO_DATA_OFFSET unless date.nil?
        end
        nil
      end

    end
  end
end