const supplierContract = artifacts.require("Supplier");
const supplierFacilityContract = artifacts.require("SupplierFacility");

contract("SupplierFacility", (accounts) => {
  let supplier;
  let supplierFacility;

  beforeEach(async () => {
    supplier = await supplierContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
    supplierFacility = await supplierFacilityContract.new("0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4", {from: accounts[0]});
  })

  it("...can create new facilities", async () => {
    // Create Customer
    let tx = await supplier.create("Off-taker Pro", {from: accounts[0]});
    let supplierId = tx.logs[0].args[0].toNumber();

    tx = await supplierFacility.create("OT Pro HQ", supplierId, {from: accounts[0]});
    let id = tx.logs[0].args[0].toNumber();
    let response = await supplierFacility.get.call(id);
    assert.equal(response.name, "OT Pro HQ", "The supplier facility was not created successfully");
    assert.equal(response.supplierId, supplierId, "The supplier facility was not created successfully");
  });
});
