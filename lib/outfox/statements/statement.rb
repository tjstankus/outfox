module Outfox
  module Statements
    class Statement
      
      [ :bank_routing_number, 
        :account_number, 
        :account_type
      ].each do |meth|
        define_method(meth) { raise "implement in subclass" }
      end
      
    end
  end
end