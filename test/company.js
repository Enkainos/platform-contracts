const companyContract = artifacts.require("Company");

contract("Company", (accounts) => {
  let company;

  beforeEach(async () => {
    company = await companyContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
  })

  it("...can create new companies", async () => {
    let tx = await company.create("Enkainos", {from: accounts[0]});
    let id = tx.logs[0].args[0].toNumber();
    let name = await company.get.call(id);
    assert.equal(name, "Enkainos", "The name was not stored.");

    tx = await company.create("Harrison Enterprises", {from: accounts[0]});
    id = tx.logs[0].args[0].toNumber();
    name = await company.get.call(id);
    assert.equal(name, "Harrison Enterprises", "The name was not stored.");
  });
});
