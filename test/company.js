let company;

const companyContract = artifacts.require("Company");

contract("Company", accounts => {

  beforeEach(async () => {
    company = await companyContract.deployed({gasPrice: 15000000});
  })

  it("...should store the name", async () => {
    const tx = await company.setName("Enkainos", {from: accounts[0], gasPrice: 15000000});
    const name = await company.getName.call();
    assert.equal(name, "Enkainos", "The value name was not stored.");
  });
});
