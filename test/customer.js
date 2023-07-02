const companyContract = artifacts.require("Company");
const customerContract = artifacts.require("Customer");
const operationContract = artifacts.require("Operation");

contract("Customer", (accounts) => {
  let company;
  let customer;
  let operation;
  let customerId;

  beforeEach(async () => {
    company = await companyContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
    customer = await customerContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
    operation = await operationContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
  })

  it("...can create new customers", async () => {
    let tx = await customer.create("Off-taker Pro", {from: accounts[0]});
    customerId = tx.logs[0].args[0].toNumber();
    let response = await customer.get.call(customerId);
    assert.equal(response.name, "Off-taker Pro", "The customer was not created successfully");

    tx = await customer.create("Oil Processors Inc.", {from: accounts[0]});
    customerId = tx.logs[0].args[0].toNumber();
    response = await customer.get.call(customerId);
    assert.equal(response.name, "Oil Processors Inc.", "The customer was not created successfully");
  });

  it("...can add operations", async () => {
    // Create Company
    let tx = await company.create("Enkainos", {from: accounts[0]});
    let companyId = tx.logs[0].args[0].toNumber();

    // Create Operation
    tx = await operation.create("Enkainos Main Campus", companyId, {from: accounts[0]});
    let operationId = tx.logs[0].args[0].toNumber();

    await customer.addOperation(customerId, operationId, {from: accounts[0]});
    let response = await customer.get.call(customerId);
    assert.equal(response.operations[0], operationId, "The operation was not added successfully");
  });

  it("...can remove operations", async () => {
    // Create Company
    let tx = await company.create("Enkainos", {from: accounts[0]});
    let companyId = tx.logs[0].args[0].toNumber();

    // Create and add Operation
    tx = await operation.create("Enkainos Main Campus", companyId, {from: accounts[0]});
    let operationId = tx.logs[0].args[0].toNumber();
    await customer.addOperation(customerId, operationId, {from: accounts[0]});

    await customer.removeOperation(customerId, operationId, {from: accounts[0]});
    let response = await customer.get.call(customerId);
    assert.equal(response.operations.length, 0, "The operation was not removed successfully");
  });
});
