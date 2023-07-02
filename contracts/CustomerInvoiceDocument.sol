// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {AccessControlCrossChainOptimism} from "./lib/AccessControlCrossChainOptimism.sol";
import {ICustomerInvoiceDocument} from "./interfaces/ICustomerInvoiceDocument.sol";

contract CustomerInvoiceDocument is ICustomerInvoiceDocument, AccessControlCrossChainOptimism {

  bytes32 public constant OWNER = keccak256("OWNER");

  uint256[] private invoices;
  string[] private documentUrls;

  event Created(uint256 indexed _id);

  constructor(address crossChainMessenger) AccessControlCrossChainOptimism(crossChainMessenger){
    _grantRole(OWNER, msg.sender);
  }

  function create(uint256 _invoiceId, string memory _documentUrl)
  public onlyRole(OWNER)
  returns (uint256 customerInvoiceDocumentId){
    uint256 id = invoices.length;
    invoices.push(_invoiceId);
    documentUrls.push(_documentUrl);
    emit Created(id);
    return id;
  }

  function get(uint256 id)
  public view
  returns (uint256 invoiceId, string memory documentUrl) {
    return (invoices[id], documentUrls[id]);
  }
}
