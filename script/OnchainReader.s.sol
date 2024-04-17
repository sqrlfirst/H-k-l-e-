// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/console2.sol";

// forge script script/misc/DynamicArray.s.sol:MyScript -vvvv

contract MyContract {
    uint256[] private dynamicArray;

    function addElement(uint256 element) public {
        dynamicArray.push(element);
    }
}

contract MyScript is Script {
    function getFullArray(
        uint256 startSlot,
        address targetContract
    ) public view returns (uint256[] memory) {
        // Load the start slot from storage
        bytes32 slotVal = vm.load(targetContract, bytes32(startSlot));
        // The first slot contains the size of the array
        uint256 arrayLength = uint256(slotVal);

        // Initialize an array in memory to hold the values we retrieve from storage
        uint256[] memory fullArr = new uint256[](arrayLength);
        // Calculate the start of the contiguous section in storage containing the array contents
        bytes32 startSlot = keccak256(abi.encodePacked(startSlot));
        // Iterate through the slots containing the array contents and store them in memory;
        for (uint256 i = 0; i < arrayLength; i++) {
            slotVal = vm.load(targetContract, bytes32(uint256(startSlot) + i));
            fullArr[i] = uint256(slotVal);
        }
        return fullArr;
    }

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        MyContract s = new MyContract();
        s.addElement(53);
        s.addElement(54);
        s.addElement(55);

        uint256[] memory a = getFullArray(0, address(s));
        for (uint256 i = 0; i < a.length; i++) {
            console2.log(a[i]);
        }

        vm.stopBroadcast();
    }
}
