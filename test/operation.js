const companyContract = artifacts.require("Company");
const operationContract = artifacts.require("Operation");

contract("Operation", (accounts) => {
  let company;
  let operation;

  beforeEach(async () => {
    company = await companyContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
    operation = await operationContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
  })

  it("...can create new operations", async () => {
    let tx = await company.create("Enkainos", {from: accounts[0]});
    let companyId = tx.logs[0].args[0].toNumber();

    tx = await operation.create("Enkainos Main Campus", companyId, {from: accounts[0]});
    let id = tx.logs[0].args[0].toNumber();
    let response = await operation.get.call(id);
    assert.equal(response.name, "Enkainos Main Campus", "The operation was not created successfully");

    tx = await operation.create("Enkainos R&D", companyId, {from: accounts[0]});
    id = tx.logs[0].args[0].toNumber();
    response = await operation.get.call(id);
    assert.equal(response.name, "Enkainos R&D", "The operation was not created successfully");
  });
});
