// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {AccessControlCrossChainOptimism} from "./lib/AccessControlCrossChainOptimism.sol";
import {ISupplierInvoiceDocument} from "./interfaces/ISupplierInvoiceDocument.sol";

contract SupplierInvoiceDocument is ISupplierInvoiceDocument, AccessControlCrossChainOptimism {

  bytes32 public constant OWNER = keccak256("OWNER");

  uint256[] private invoices;
  string[] private documentUrls;

  constructor(address crossChainMessenger) AccessControlCrossChainOptimism(crossChainMessenger){
    _grantRole(OWNER, msg.sender);
  }

  function create(
    uint256 _invoiceId,
    string memory _documentUrl
  )
  public onlyRole(OWNER)
  returns (uint256 supplierInvoiceDocumentId){
    uint256 id = invoices.length;
    invoices.push(_invoiceId);
    documentUrls.push(_documentUrl);
    return id;
  }

  function get(uint256 id)
  public view
  returns (uint256 invoiceId, string memory documentUrl) {
    return (invoices[id], documentUrls[id]);
  }
}
