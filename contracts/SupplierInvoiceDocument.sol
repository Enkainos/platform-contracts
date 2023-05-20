// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/AccessControlCrossChain.sol";
import "@openzeppelin/contracts/crosschain/optimism/CrossChainEnabledOptimism.sol";

contract SupplierInvoiceDocument is CrossChainEnabledOptimism, AccessControlCrossChain {

  bytes32 public constant OWNER = keccak256("OWNER");

  uint256[] private invoice;
  string[] private documentUrl;

  constructor(address crossChainMessenger) CrossChainEnabledOptimism(crossChainMessenger){}

  function create(
    uint256 memory _invoiceId,
    string memory _documentUrl
  )
  public require(hasRole(OWNER, msg.sender))
  returns (uint256 memory invoiceId){
    uint256 id = invoice.length;
    invoice[id] = _invoiceId;
    documentUrl[id] = _documentUrl;
    return id;
  }

  function get(uint256 calldata id)
  public view
  returns (uint256 invoiceId, string memory) {
    return (invoice[id], documentUrl[id]);
  }
}
