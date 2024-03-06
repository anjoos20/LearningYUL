// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.2;

contract YulStorage {
    uint256 val = 99;
    uint256 val1 = 199; // slot 1
    uint256 val2 = 188; // slot 2
    // begin slot 3
    // Variables of lenght < 256 bits are packed together in a single slot
    // There is an offset for each variable and with the help of that we can get the value of each
    uint128 public a=9;
    uint96 public b=7;
    uint16 public c=5;
    uint8 public d=3;
    uint8 public e=2;
    // end slot 3     

    function getSlotYul() external pure returns(uint256 r) {
        
        assembly {

            //r := val will give a compilation error 
            //Only local variables are supported. 
            //To access storage variables, use the ".slot" and ".offset" suffixes.
            r:=val.slot // gives 0
            // val1.slot is 1
            //val2.slot is 2
            // a.slot is 3
            //b.slot is 3
            //c.slot is 3
            //d.slot is 3
            //e.slot is 3
        }
    }

    function getValYul() external view returns(uint256 r) {
        assembly {
            // Returns 99
            r := sload(val.slot)
        
    }
}
function getValueBySlotIndex(uint256 slotIndex) external view returns(uint256 ret) {
        assembly {
            ret := sload(slotIndex)
        }
    }
// *******This is not recommended to do in production*****
//Its dangerous because it might create a vulnurability in 
//the smart contract such that you could easily change the owner.
// Suppose you select a random slot which is for the owner related 
//********************************************************
function setValueBySlotIndexAndVal(uint256 slotIndex, uint256 newVal) external {
        assembly {
            sstore(slotIndex, newVal)
        }
    }

    function getSlotAndOffset() external pure returns(uint256 slot, uint256 offset) {
        assembly {
            // Here we get the offset as 28 which means its 28 bytes back from the left edge to 
            //where that data is actually located
            //                                 e|d|  c|                      b|                              a|                     
            // The bytes32 data at slot 3 is 0x0203000500000000000000000000000700000000000000000000000000000009
            //                               323130292827262524232221201918171615141312111009080706050403020100 
            slot := c.slot
            offset := c.offset
        }
    }

}