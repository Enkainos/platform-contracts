const companyContract = artifacts.require("Company");
const customerContract = artifacts.require("Customer");
const customerFacilityContract = artifacts.require("CustomerFacility");
const customerInvoiceContract = artifacts.require("CustomerInvoice");
const operationContract = artifacts.require("Operation");

contract("CustomerInvoice", (accounts) => {
  let company;
  let customer;
  let customerFacility;
  let customerInvoice;
  let operation;

  beforeEach(async () => {
    company = await companyContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
    customer = await customerContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
    customerFacility = await customerFacilityContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
    customerInvoice = await customerInvoiceContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
    operation = await operationContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
  })

  it("...can create new invoices", async () => {
    // Create Customer
    let tx = await customer.create("Off-taker Pro", {from: accounts[0]});
    let customerId = tx.logs[0].args[0].toNumber();

    // Create Company
    tx = await company.create("Enkainos", {from: accounts[0]});
    let companyId = tx.logs[0].args[0].toNumber();

    // Create Operation
    tx = await operation.create("Enkainos Main Campus", companyId, {from: accounts[0]});
    let operationId = tx.logs[0].args[0].toNumber();

    // Create facility
    tx = await customerFacility.create("OT Pro HQ", customerId, {from: accounts[0]});
    let facilityId = tx.logs[0].args[0].toNumber();

    tx = await customerInvoice.create(customerId, operationId, facilityId, [0, 1, 2], [50, 100, 10], 10, {from: accounts[0]});
    let id = tx.logs[0].args[0].toNumber();
    let response = await customerInvoice.get.call(id);
    assert.equal(response.customerId, customerId, "The customer invoice was not created successfully");
    assert.equal(response.operationId, operationId, "The customer invoice was not created successfully");
    assert.equal(response.facilityId, facilityId, "The customer invoice was not created successfully");
    assert.equal(response.materials[0], 0, "The customer invoice was not created successfully");
    assert.equal(response.materials[1], 1, "The customer invoice was not created successfully");
    assert.equal(response.materials[2], 2, "The customer invoice was not created successfully");
    assert.equal(response.quantities[0], 50, "The customer invoice was not created successfully");
    assert.equal(response.quantities[1], 100, "The customer invoice was not created successfully");
    assert.equal(response.quantities[2], 10, "The customer invoice was not created successfully");
    assert.equal(response.timestamp, 10, "The customer invoice was not created successfully");
  });
});
