// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract YulStorageComplex {
     mapping(uint256 => uint256) public simpleMapping;
    mapping(uint256 => mapping(uint256 => uint256)) public nestedMapping;
    mapping(address => uint256[]) public addressToListMapping;

    constructor(){
         // mappings
        simpleMapping[88] = 1;
        simpleMapping[99] = 2;

        nestedMapping[9][8] = 7;
        nestedMapping[99][88] = 77;
        addressToListMapping[0xC8BF81e2d65cba23635fAeDD18e2c08caD1c5271] = [55,44,33];
    }

    function getMappingValue(uint256 key) external view returns(uint256 value) {
        uint256 slot;
        assembly {
            slot := simpleMapping.slot
        }
        // Keccak256 the key together with the slot of the mapping
        bytes32 dataLocation = keccak256(abi.encode(key, slot));

        assembly {
            value := sload(dataLocation)
        }
    }

    function getNestedMappingValue(uint256 key1, uint256 key2) external view returns(uint256 value) {
        uint256 slot;
        assembly {
            slot := nestedMapping.slot
        }
        // keccaak256 of the combination of keys and slots to give the location
        // The keys are hashed from left to right even though in the actual mapping its  right to left
        // key1: 9 is the left most key but its the rightmost value that's hashed which is then combined with key2
        // and then hashed together, to get the data location
        bytes32 dataLocation = keccak256(abi.encode(key2, keccak256(abi.encode(key1, slot))));

        assembly {
            value := sload(dataLocation)
        }
    }

    function getAddressMappedArrayLength() external view returns(uint256 value) {
        uint256 slot;
        assembly {
            slot := addressToListMapping.slot
        }
    // keccak256 of the key with the slot will give the data location
    // i.e. the location of the value which happens to be a dynamic array
    // And so the first value of that slot is going to be the length
    // To get data location, do a keccak256 on keccak256 of the key and the slot
       bytes32 dataLocation = keccak256(abi.encode(0xC8BF81e2d65cba23635fAeDD18e2c08caD1c5271, slot));

        assembly {
            value := sload(dataLocation)
        }
    }

    function getAddressMappedArrayData(uint256 index) external view returns(uint256 value) {
        uint256 slot;
        assembly {
            slot := addressToListMapping.slot
        }

       bytes32 dataLocation = keccak256(abi.encode(keccak256(abi.encode(0xC8BF81e2d65cba23635fAeDD18e2c08caD1c5271, slot))));

        assembly {
            value := sload(add(dataLocation, index))
        }
    }
}