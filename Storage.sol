// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.2;

contract YulStorage {
    uint256 val = 99;
    uint256 val1 = 199; // slot 1
    uint256 val2 = 188; // slot 2
    // begin slot 3
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
}

