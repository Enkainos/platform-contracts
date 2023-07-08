const companyContract = artifacts.require("Company");
const supplierContract = artifacts.require("Customer");
const supplierInvoiceContract = artifacts.require("SupplierInvoice");
const supplierInvoiceDocumentContract = artifacts.require("SupplierInvoiceDocument");
const operationContract = artifacts.require("Operation");

contract("SupplierInvoiceDocument", (accounts) => {
  let company;
  let supplier;
  let supplierInvoice;
  let supplierInvoiceDocument;
  let operation;

  beforeEach(async () => {
    company = await companyContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
    supplier = await supplierContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
    supplierInvoice = await supplierInvoiceContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
    supplierInvoiceDocument = await supplierInvoiceDocumentContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
    operation = await operationContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
  })

  it("...can create new invoice documents", async () => {
    // Create Customer
    let tx = await supplier.create("Off-taker Pro", {from: accounts[0]});
    let supplierId = tx.logs[0].args[0].toNumber();

    // Create Company
    tx = await company.create("Enkainos", {from: accounts[0]});
    let companyId = tx.logs[0].args[0].toNumber();

    // Create Operation
    tx = await operation.create("Enkainos Main Campus", companyId, {from: accounts[0]});
    let operationId = tx.logs[0].args[0].toNumber();

    // Create SupplierInvoice
    tx = await supplierInvoice.create(supplierId, operationId, [0, 1, 2], [50, 100, 10], 10, {from: accounts[0]});
    let invoiceId = tx.logs[0].args[0].toNumber();

    tx = await supplierInvoiceDocument.create(invoiceId, "https://documents.com", {from: accounts[0]});
    let id = tx.logs[0].args[0].toNumber();
    let response = await supplierInvoiceDocument.get.call(id);
    assert.equal(response.invoiceId, invoiceId, "The customer invoice document was not created successfully");
    assert.equal(response.documentUrl, "https://documents.com", "The customer invoice document was not created successfully");
  });
});
