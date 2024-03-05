// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract YulTypes {
    function numberType() external pure returns(uint256) {
        uint256 x;

        assembly {
            // YUL doesnt need a semicolon at the end of statements
            // Its like a shared scope here. X can actually reach out of the scope and access the value
            x := 88
        }

        return x;
    }

    function hexType() external pure returns(uint256) {
        uint256 x;

        assembly {
            x := 0xc // 12
        }
    // Its returned in uint256
        return x;
    }

}