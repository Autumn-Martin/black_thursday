class Item

  attr_reader     :id,
                  :created_at,
                  :merchant_id

  attr_accessor   :name,
                  :description,
                  :unit_price,
                  :updated_at

  def initialize(info)
    @id = info[:id].to_i
    @name = info[:name]
    @description = info[:description]
    @unit_price = info[:unit_price]
    @created_at = info[:created_at]
    #Time.parse
    @updated_at = info[:updated_at]
    #Time.parse
    @merchant_id = info[:merchant_id].to_i
  end

  def unit_price_to_dollars
    if @unit_price.include?(".")
      @unit_price.to_f
    else
      @unit_price.insert(-3, ".").to_f
    end

  end
end
