require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice_item'
require_relative './test_helper'

class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    @invoice_items =
    [
      { id: 1,
        item_id: 263519841,
        invoice_id: 1,
        quantity: 5,
        unit_price: 13635,
        created_at: '2001-01-01 14:54:09 UTC',
        updated_at: '2011-01-01 14:54:09 UTC'},
      { id: 2,
        item_id: 263519842,
        invoice_id: 2,
        quantity: 2,
        unit_price: 23635,
        created_at: '2002-02-02 14:54:09 UTC',
        updated_at: '2012-02-02 14:54:09 UTC'},
      { id: 3,
        item_id: 263519843,
        invoice_id: 3,
        quantity: 3,
        unit_price: 33635,
        created_at: '2003-03-03 14:54:09 UTC',
        updated_at: '2013-03-03 14:54:09 UTC'}
    ]
    @iir = InvoiceItemRepository.new(@invoice_items)
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @iir
  end

  def test_it_can_build_invoice
    assert_equal Array, @iir.build_invoice(@invoice_items).class
  end

  def test_it_can_return_an_array_of_all_known_invoice_item_instances
    assert_equal 3, @iir.all.count
  end

  def test_it_can_find_an_invoice_item_by_a_valid_id
    item = @iir.find_by_id(1)
    assert_instance_of InvoiceItem, item
    assert_equal 1, item.id
  end
end
