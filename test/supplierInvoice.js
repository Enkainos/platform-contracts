const companyContract = artifacts.require("Company");
const supplierContract = artifacts.require("Supplier");
const supplierInvoiceContract = artifacts.require("SupplierInvoice");
const operationContract = artifacts.require("Operation");

contract("SupplierInvoice", (accounts) => {
  let company;
  let supplier;
  let supplierInvoice;
  let operation;

  beforeEach(async () => {
    company = await companyContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
    supplier = await supplierContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
    supplierInvoice = await supplierInvoiceContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
    operation = await operationContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
  })

  it("...can create new invoices", async () => {
    // Create Customer
    let tx = await supplier.create("Off-taker Pro", {from: accounts[0]});
    let supplierId = tx.logs[0].args[0].toNumber();

    // Create Company
    tx = await company.create("Enkainos", {from: accounts[0]});
    let companyId = tx.logs[0].args[0].toNumber();

    // Create Operation
    tx = await operation.create("Enkainos Main Campus", companyId, {from: accounts[0]});
    let operationId = tx.logs[0].args[0].toNumber();

    tx = await supplierInvoice.create(supplierId, operationId, [0, 1, 2], [50, 100, 10], 10, {from: accounts[0]});
    let id = tx.logs[0].args[0].toNumber();
    let response = await supplierInvoice.get.call(id);
    assert.equal(response.supplierId, supplierId, "The customer invoice was not created successfully");
    assert.equal(response.operationId, operationId, "The customer invoice was not created successfully");
    assert.equal(response.materials[0], 0, "The customer invoice was not created successfully");
    assert.equal(response.materials[1], 1, "The customer invoice was not created successfully");
    assert.equal(response.materials[2], 2, "The customer invoice was not created successfully");
    assert.equal(response.quantities[0], 50, "The customer invoice was not created successfully");
    assert.equal(response.quantities[1], 100, "The customer invoice was not created successfully");
    assert.equal(response.quantities[2], 10, "The customer invoice was not created successfully");
    assert.equal(response.timestamp, 10, "The customer invoice was not created successfully");
  });
});
