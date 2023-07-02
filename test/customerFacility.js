const customerContract = artifacts.require("Customer");
const customerFacilityContract = artifacts.require("CustomerFacility");

contract("CustomerFacility", (accounts) => {
  let customer;
  let customerFacility;

  beforeEach(async () => {
    customer = await customerContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
    customerFacility = await customerFacilityContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
  })

  it("...can create new facilities", async () => {
    // Create Customer
    let tx = await customer.create("Off-taker Pro", {from: accounts[0]});
    let customerId = tx.logs[0].args[0].toNumber();

    tx = await customerFacility.create("OT Pro HQ", customerId, {from: accounts[0]});
    let id = tx.logs[0].args[0].toNumber();
    let response = await customerFacility.get.call(id);
    assert.equal(response.name, "OT Pro HQ", "The customer facility was not created successfully");
    assert.equal(response.customerId, customerId, "The customer facility was not created successfully");
  });
});
