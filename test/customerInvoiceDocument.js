const companyContract = artifacts.require("Company");
const customerContract = artifacts.require("Customer");
const customerInvoiceContract = artifacts.require("CustomerInvoice");
const customerInvoiceDocumentContract = artifacts.require("CustomerInvoiceDocument");
const operationContract = artifacts.require("Operation");

contract("CustomerInvoiceDocument", (accounts) => {
  let company;
  let customer;
  let customerInvoice;
  let customerInvoiceDocument;
  let operation;

  beforeEach(async () => {
    company = await companyContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
    customer = await customerContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
    customerInvoice = await customerInvoiceContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
    customerInvoiceDocument = await customerInvoiceDocumentContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
    operation = await operationContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
  })

  it("...can create new invoice documents", async () => {
    // Create Customer
    let tx = await customer.create("Off-taker Pro", {from: accounts[0]});
    let customerId = tx.logs[0].args[0].toNumber();

    // Create Company
    tx = await company.create("Enkainos", {from: accounts[0]});
    let companyId = tx.logs[0].args[0].toNumber();

    // Create Operation
    tx = await operation.create("Enkainos Main Campus", companyId, {from: accounts[0]});
    let operationId = tx.logs[0].args[0].toNumber();

    // Create CustomerInvoice
    tx = await customerInvoice.create(customerId, operationId, [0, 1, 2], [50, 100, 10], 10, {from: accounts[0]});
    let invoiceId = tx.logs[0].args[0].toNumber();

    tx = await customerInvoiceDocument.create(invoiceId, "https://documents.com", {from: accounts[0]});
    let id = tx.logs[0].args[0].toNumber();
    let response = await customerInvoiceDocument.get.call(id);
    assert.equal(response.invoiceId, invoiceId, "The customer invoice document was not created successfully");
    assert.equal(response.documentUrl, "https://documents.com", "The customer invoice document was not created successfully");
  });
});
