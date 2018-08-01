require_relative 'file_loader'
require_relative 'sales_analyst'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'
require_relative 'repo_methods'

class SalesEngine
  include RepoMethods
  include FileLoader
  attr_reader :path

  def self.from_csv(path)
    SalesEngine.new(path)
  end

  def initialize(path)
    @path = path
  end

  def analyst
    @analyst = SalesAnalyst.new(self)
  end

  def merchants
    @merchants ||= MerchantRepository.new(builder(path[:merchants]))
  end

  def items
    @items ||= ItemRepository.new(builder(path[:items]))
  end

  def invoices
    @invoices ||= InvoiceRepository.new(builder(path[:invoices]))
  end

  def invoice_items
    @invoice_items ||= InvoiceItemRepository.new(builder(path[:invoice_items]))
  end

  def transactions
    @transactions ||= TransactionRepository.new(builder(path[:transactions]))
  end

  def customers
    @customers ||= CustomerRepository.new(builder(path[:customers]))
  end
end
