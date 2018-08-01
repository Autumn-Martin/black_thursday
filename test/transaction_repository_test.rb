require_relative './test_helper'
require './lib/transaction'
require './lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  def setup
    @transactions =
      [{  id: 1,
          invoice_id: 2171,
          credit_card_number: '4068631943231471',
          credit_card_expiration_date: '0211',
          result: 'success',
          created_at: '2001-01-01 20:56:56 UTC',
          updated_at: '2011-01-01 20:56:56 UTC' },
       {  id: 2,
          invoice_id: 2172,
          credit_card_number: '4068631943231472',
          credit_card_expiration_date: '0212',
          result: 'success',
          created_at: '2002-02-02 20:56:56 UTC',
          updated_at: '2012-02-02 20:56:56 UTC' },
       {  id: 3,
          invoice_id: 2173,
          credit_card_number: '4068631943231473',
          credit_card_expiration_date: '0213',
          result: 'failed',
          created_at: '2003-03-03 20:56:56 UTC',
          updated_at: '2013-03-03 20:56:56 UTC' },
       {  id: 4,
          invoice_id: 2174,
          credit_card_number: '4068631943231474',
          credit_card_expiration_date: '0214',
          result: 'success',
          created_at: '2004-04-04 20:56:56 UTC',
          updated_at: '2014-04-04 20:56:56 UTC' }]

    @transaction = TransactionRepository.new(@transactions)
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @transaction
  end

  def test_it_can_build_transaction
    assert_equal Array, @transaction.build_transaction(@transactions).class
  end

  def test_it_can_return_an_array_of_all_known_transaction_instances
    assert_equal 4, @transaction.all.count
  end

  def test_it_can_find_a_transaction_by_a_valid_id
    transaction = @transaction.find_by_id(1)
    assert_instance_of Transaction, transaction
    assert_equal 1, transaction.id
  end

  def test_it_returns_nil_if_transaction_id_is_invalid
    transaction = @transaction.find_by_id('invalid')
    assert_nil transaction
  end

  def test_it_can_find_all_by_invoice_id
    trans_one = @transaction.find_all_by_invoice_id(2171)
    trans_two = @transaction.find_all_by_invoice_id(2172)
    trans_three = @transaction.find_all_by_invoice_id(5)
    assert_equal 2171, trans_one.first.invoice_id
    assert_equal 2172, trans_two.first.invoice_id
    assert_equal 2172, trans_two[-1].invoice_id
    assert_equal [], trans_three
  end

  def test_it_can_find_all_by_credit_card_number
    trans_one = @transaction.find_all_by_credit_card_number('4068631943231471')
    trans_two = @transaction.find_all_by_credit_card_number('4068631943231472')
    trans_three = @transaction.find_all_by_credit_card_number('406863194323147')
    assert_equal '4068631943231471', trans_one.first.credit_card_number
    assert_equal '4068631943231472', trans_two.first.credit_card_number
    assert_equal '4068631943231472', trans_two[-1].credit_card_number
    assert_equal [], trans_three
  end

  def test_it_can_find_all_by_result
    trans_one = @transaction.find_all_by_result('success')
    trans_two = @transaction.find_all_by_result('failed')
    trans_three = @transaction.find_all_by_result('invalid')
    assert_equal :success, trans_one.first.result
    assert_equal :failed, trans_two.first.result
    assert_equal :failed, trans_two[-1].result
    assert_equal [], trans_three
  end

  def test_it_can_create_new_id
    transaction = @transaction.create_id
    assert_equal 5, transaction
  end

  def test_it_can_create_new_invoice_item
    attributes = {  invoice_id: 2775,
                    credit_card_number: '4068631943231475',
                    credit_card_expiration_date: '0215',
                    result: 'success',
                    created_at: '2018-07-28',
                    updated_at: '2018-07-28' }
    transaction = @transaction.create(attributes)
    assert_equal 5, transaction.id
    assert_equal 2775, transaction.invoice_id
    assert_equal '4068631943231475', transaction.credit_card_number
    assert_equal '0215', transaction.credit_card_expiration_date
    assert_equal :success, transaction.result
    assert_instance_of Time, transaction.created_at
    assert_instance_of Time, transaction.updated_at
  end

  def test_it_can_update_transaction
    attributes = {
      credit_card_number: '4068631943231477',
      credit_card_expiration_date: '0722',
      result: 'success'
    }
    id = 1
    @transaction.update(id, attributes)
    expected = @transaction.find_by_id(id)
    assert_instance_of Time, expected.updated_at # maybe refactor later
    assert_equal 2171, expected.invoice_id
    assert_equal 1, expected.id
    assert_equal '4068631943231477', expected.credit_card_number
    assert_equal '0722', expected.credit_card_expiration_date
    assert_equal :success, expected.result
  end

  def test_it_can_delete_invoice
    id = 2

    @transaction.delete(id)
    expected = @transaction.find_by_id(2)

    assert_nil expected
  end
end
