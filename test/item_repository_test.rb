require_relative '../lib/item_repository'
require_relative '../lib/item'
require_relative './test_helper'

class ItemRepositoryTest < Minitest::Test
  def setup
    @items =
      [{id: 1,
      name: 'OneThing',
      description:'a car thing that does stuff',
      unit_price: 1500,
      merchant_id: 1,
      created_at: '2018-07-22',
      updated_at: '2018-07-22'},
      {id: 2,
      name: 'TwoThing',
      description:'a bike thing that does stuff',
      unit_price: 1370,
      merchant_id: 1,
      created_at: '2018-07-22',
      updated_at: '2018-07-22'},
      {id: 3,
      name: 'ThreeThing',
      description:'a scooter thing that does stuff',
      unit_price: 1500,
      merchant_id: 2,
      created_at: '2018-01-22',
      updated_at: '2018-07-22'},
      {id: 4,
      name: 'FourThing',
      description:'a skateboard thing that does stuff',
      unit_price: 1300,
      merchant_id: 2,
      created_at: '2018-03-22',
      updated_at: '2018-07-27'},
      {id: 5,
      name: 'FiveThing',
      description:'a boat thing that does stuff',
      unit_price: 1500,
      merchant_id: 2,
      created_at: '2018-02-23',
      updated_at: '2018-06-22'},
      {id: 6,
      name: 'SixThing',
      description:'a kayak thing that does stuff',
      unit_price: 12400,
      merchant_id: 3,
      created_at: '2018-04-22',
      updated_at: '2018-07-12'}]

    @item_repository = ItemRepository.new(@items)
  end

  def test_it_exists
    assert_instance_of ItemRepository, @item_repository
  end

  def test_it_can_build_item
    assert_equal Array, @item_repository.build_item(@items).class
  end

  def test_can_get_an_array_of_items
    assert_equal 6, @item_repository.all.count
  end

  def test_it_can_find_an_item_by_a_valid_id
    item = @item_repository.find_by_id(3)
    assert_instance_of Item, item
    assert_equal 3, item.id
  end

  def test_it_returns_nil_if_item_id_is_invalid
    item = @item_repository.find_by_id('invalid')
    assert_nil item
  end

  def test_it_can_find_a_item_by_name
    item = @item_repository.find_by_name('OneThing')
    assert_instance_of Item, item
    assert_equal 'OneThing', item.name
  end

  def test_it_returns_nil_if_item_name_is_invalid
    item = @item_repository.find_by_name('invalid')
    assert_nil item
  end

  def test_item_find_by_name_is_case_insensitive
    item = @item_repository.find_by_name('tWOThing')
    assert_equal 'TwoThing', item.name
  end

  def test_find_all_items_with_description
    items_1 = @item_repository.find_all_with_description('bike')
    items_2 = @item_repository.find_all_with_description('zzzz')
    items_3 = @item_repository.find_all_with_description('stuff')
    assert_equal 'a bike thing that does stuff', items_1.first.description
    assert_equal ([]), items_2
    assert_equal 'a car thing that does stuff', items_3.first.description
    assert_equal 'a kayak thing that does stuff', items_3[-1].description
    assert_equal 6, items_3.count
  end

  def test_it_can_find_all_with_price
    items_1 = @item_repository.find_all_by_price(1300)
    items_2 = @item_repository.find_all_by_price(9900)
    items_3 = @item_repository.find_all_by_price(1500)

    assert_equal 1300, items_1.first.unit_price
    assert_equal ([]), items_2
    assert_equal 3, items_3.count
  end

  def test_it_can_find_all_items_within_a_price_range
    items_1 = @item_repository.find_all_by_price_in_range(0..1300)
    items_2 = @item_repository.find_all_by_price_in_range(9800..9900)
    items_3 = @item_repository.find_all_by_price_in_range(0..12500)

    assert_equal 1300, items_1.first.unit_price
    assert_equal ([]), items_2
    assert_equal 6, items_3.count
  end

  def test_it_can_find_all_items_by_merchant_id
    items_1 = @item_repository.find_all_by_merchant_id(1)
    items_2 = @item_repository.find_all_by_merchant_id(99)
    items_3 = @item_repository.find_all_by_merchant_id(2)

    assert_equal 1500, items_1.first.unit_price
    assert_equal ([]), items_2
    assert_equal 3, items_3.count
  end
end
