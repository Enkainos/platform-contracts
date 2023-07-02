const materialContract = artifacts.require("Material");

contract("Material", (accounts) => {
  let material;

  beforeEach(async () => {
    material = await materialContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
  })

  it("...can create new materials", async () => {
    let tx = await material.create("Styrofoam", "lbs.", 2, {from: accounts[0]});
    let id = tx.logs[0].args[0].toNumber();
    let response = await material.get.call(id);
    assert.equal(response.name, "Styrofoam", "The material was not created successfully");
    assert.equal(response.unit, "lbs.", "The material was not created successfully");
    assert.equal(response.precision, 2, "The material was not created successfully");
  });
});
