require_relative 'transaction'
require_relative 'repo_methods'

class TransactionRepository
  include RepoMethods

  def initialize(transaction_data)
    @transaction_rows ||= build_transaction(transaction_data)
    @repo = @transaction_rows
  end

  def build_transaction(transaction_data)
    transaction_data.map do |transaction|
      Transaction.new(transaction)
    end
  end


end