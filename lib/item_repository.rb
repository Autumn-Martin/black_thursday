class ItemRepository
  def initialize(item_data)
    @item_rows ||= build_item(item_data)
    @items = @item_rows
  end

  def build_item(item_data)
    item_data.map do |item|
      Item.new(item)
    end
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @items.find do |item|
      item.name.casecmp(name).zero?
    end
  end

  def find_all_with_description(description)
    @items.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price == price
    end
  end
end
