require_relative './test_helper'
require './lib/transaction'
require './lib/transaction_repository'

class TransactionRepositoryTest < Minitest::Test
  def setup
    transactions =
    [
      { id: 1,
        invoice_id: 2171,
        credit_card_number: '4068631943231471',
        credit_card_expiration_date: '0211',
        result: 'success',
        created_at: '2001-01-01 20:56:56 UTC',
        updated_at: '2011-01-01 20:56:56 UTC'
        },
      {
        id: 2,
        invoice_id: 2172,
        credit_card_number: '4068631943231472',
        credit_card_expiration_date: '0212',
        result: 'success',
        created_at: '2002-02-02 20:56:56 UTC',
        updated_at: '2012-02-02 20:56:56 UTC'
        },
      {
        id: 3,
        invoice_id: 2173,
        credit_card_number: '4068631943231473',
        credit_card_expiration_date: '0213',
        result: 'failed',
        created_at: '2003-03-03 20:56:56 UTC',
        updated_at: '2013-03-03 20:56:56 UTC'
        },
      {
        id: 4,
        invoice_id: 2174,
        credit_card_number: '4068631943231474',
        credit_card_expiration_date: '0214',
        result: 'success',
        created_at: '2004-04-04 20:56:56 UTC',
        updated_at: '2014-04-04 20:56:56 UTC'
        }
    ]

    @transaction = TransactionRepository.new(transactions)
  end

  def test_it_exists
    assert_instance_of TransactionRepository, @transaction    
  end
end