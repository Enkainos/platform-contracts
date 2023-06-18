// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/AccessControlCrossChain.sol";
import "@openzeppelin/contracts/crosschain/optimism/LibOptimism.sol";

abstract contract AccessControlCrossChainOptimism is AccessControlCrossChain {
    address private immutable _messenger;

    constructor(address crossChainMessenger) CrossChainEnabled(){
        _messenger = crossChainMessenger;
    }

    function _isCrossChain() internal view virtual override returns (bool) {
        return LibOptimism.isCrossChain(_messenger);
    }

    function _crossChainSender() internal view virtual override onlyCrossChain returns (address) {
        return LibOptimism.crossChainSender(_messenger);
    }
}