const companyContract = artifacts.require("Company");
const supplierContract = artifacts.require("Supplier");
const operationContract = artifacts.require("Operation");

contract("Supplier", (accounts) => {
  let company;
  let supplier;
  let operation;
  let supplierId;

  beforeEach(async () => {
    company = await companyContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
    supplier = await supplierContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
    operation = await operationContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
  })

  it("...can create new suppliers", async () => {
    let tx = await supplier.create("Off-taker Pro", {from: accounts[0]});
    supplierId = tx.logs[0].args[0].toNumber();
    let response = await supplier.get.call(supplierId);
    assert.equal(response.name, "Off-taker Pro", "The supplier was not created successfully");

    tx = await supplier.create("Oil Processors Inc.", {from: accounts[0]});
    supplierId = tx.logs[0].args[0].toNumber();
    response = await supplier.get.call(supplierId);
    assert.equal(response.name, "Oil Processors Inc.", "The supplier was not created successfully");
  });

  it("...can add operations", async () => {
    // Create Company
    let tx = await company.create("Enkainos", {from: accounts[0]});
    let companyId = tx.logs[0].args[0].toNumber();

    // Create Operation
    tx = await operation.create("Enkainos Main Campus", companyId, {from: accounts[0]});
    let operationId = tx.logs[0].args[0].toNumber();

    await supplier.addOperation(supplierId, operationId, {from: accounts[0]});
    let response = await supplier.get.call(supplierId);
    assert.equal(response.operations[0], operationId, "The operation was not added successfully");
  });

  it("...can remove operations", async () => {
    // Create Company
    let tx = await company.create("Enkainos", {from: accounts[0]});
    let companyId = tx.logs[0].args[0].toNumber();

    // Create and add Operation
    tx = await operation.create("Enkainos Main Campus", companyId, {from: accounts[0]});
    let operationId = tx.logs[0].args[0].toNumber();
    await supplier.addOperation(supplierId, operationId, {from: accounts[0]});

    await supplier.removeOperation(supplierId, operationId, {from: accounts[0]});
    let response = await supplier .get.call(supplierId);
    assert.equal(response.operations.length, 0, "The operation was not removed successfully");
  });
});
