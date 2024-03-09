// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Vm} from "forge-std/Vm.sol";
import {StdUtils} from "forge-std/StdUtils.sol";

abstract contract Skipper is Test, Vm {
    uint256 immutable minTime2Skip;
    uint256 immutable maxTime2Skip;

    event SomeTimeIsSkippped(uint256 timeSkiped, uint256 blockTimeStamp);

    constructor(uint256 _minTime2Skip, uint256 _maxTime2Skip) {
        minTime2Skip = _minTime2Skip;
        maxTime2Skip = _maxTime2Skip;
    }

    function skip(uint256 time2Skip) public {
        time2Skip = bound(time, minTime2Skip, maxTime2Skip);
        uint256 newTime = time2Skip + block.timestamp;

        vm.warp(newTime);
        emit SomeTimeIsSkippped(time2Skip, newTime);
    }
}
