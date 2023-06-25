let Company = artifacts.require("Company");
let Customer = artifacts.require("Customer");
let CustomerFacility = artifacts.require("CustomerFacility");
let CustomerInvoice = artifacts.require("CustomerInvoice");
let CustomerInvoiceDocument = artifacts.require("CustomerInvoiceDocument");
let Material = artifacts.require("Material");
let Operation = artifacts.require("Operation");
let Supplier = artifacts.require("Supplier");
let SupplierFacility = artifacts.require("SupplierFacility");
let SupplierInvoice = artifacts.require("SupplierInvoice");
let SupplierInvoiceDocument = artifacts.require("SupplierInvoiceDocument");


module.exports = function(deployer) {
  deployer.deploy(Company, "0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4");
  deployer.deploy(Customer, "0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4");
  deployer.deploy(CustomerFacility, "0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4");
  deployer.deploy(CustomerInvoice, "0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4");
  deployer.deploy(CustomerInvoiceDocument, "0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4");
  deployer.deploy(Material, "0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4");
  deployer.deploy(Operation, "0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4");
  deployer.deploy(Supplier, "0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4");
  deployer.deploy(SupplierFacility, "0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4");
  deployer.deploy(SupplierInvoice, "0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4");
  deployer.deploy(SupplierInvoiceDocument, "0x9D1dACf9d9299D17EFFE1aAd559c06bb3Fbf9BC4");
};
