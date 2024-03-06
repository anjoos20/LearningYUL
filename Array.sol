// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract YulStorageComplex {
    uint256[3] fixedSizeArray; 
    uint256[] dynamicArray;
    uint8[] smallArray;

     constructor() {
        // arrays
        fixedSizeArray = [66,77,88];
        dynamicArray = [9,909,90909, 9999];
        smallArray = [8,88,255];
     }

     /* Array Functions */
    function getValueFixedArray(uint256 index) external view returns (uint256 value) {
        assembly {
            value := sload(add(fixedSizeArray.slot, index))
        }
    }
    // For dynamic array, the slot is storing the length
    function getDynamicArrayLength() external view returns (uint256 length) {
        assembly {
            length := sload(dynamicArray.slot)
        }
    }

    function getDynamicArrayValue(uint256 index) external view returns(uint256 value) {
        uint256 arraySlot;
        assembly {
            arraySlot := dynamicArray.slot
        }
        // The data storing starts at the storage of the contract corresponding to keccak256 
        // of the slot, to avoid any collisions with the data it might follow!
        bytes32 dataStartSlot = keccak256(abi.encode(arraySlot));
        assembly {
            value := sload(add(dataStartSlot, index))
        }
    }

    function getSmallArrayValue(uint256 index) external view returns(bytes32 value) {
        uint256 arraySlot;
        assembly {
            arraySlot := smallArray.slot
        }

        bytes32 dataStartSlot = keccak256(abi.encode(arraySlot));
        assembly {
            value := sload(add(dataStartSlot, index))
        }
    }
}