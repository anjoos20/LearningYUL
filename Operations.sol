// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract YulOperations {

    // Check if the input is prime or not
    function isPrimeNumber(uint256 n) public pure returns (bool isPrime) {
        isPrime = true;
        assembly {
            let halfN := add(div(n, 2), 1)
            let i:= 2 
            for { } lt(i, halfN) { } {
                // for {let i:=2 } lt(i, halfN) { i:= add(i,2} {
                if iszero(mod(n, i)) {
                    isPrime := 0
                    break
                }

                i := add(i, 1)
            }
        }
}
// checking if something is true or false is different method in Yule because ut only has one datatype, that is byte32
function checkTruthy() external pure returns (uint256 result) {
        result = 88;

        assembly {
            if 99 {
                // This will always gert executed and the value will change to 99
                result := 99
            }
        }

        return result; // 99
    }

    function checkFalsy() external pure returns (uint256 result) {
        result = 88;

        assembly {
            if 0 {
                //This will never get execyed and the value will remain 88
                result := 99
            }
        }

        return result; // 88
    }

     function checkNegation() external pure returns (uint256 result) {
        result = 1;

        assembly {
            // iszero(0) is true and hence it always get executed
            if iszero(0) {
                result := 2
            }
        }

        return result; // 2
    }

    function negationUsingNotUnsafe() external pure returns (uint256 result) {
        result = 1;

        assembly {
            // Not(0) will be resulting in a truthy state always and hence result is always2
            if not(0) {
                result := 2
            }
        }

        return result; // 2
    }

    function notZero() external pure returns (bytes32 r) {
        assembly {
            // r:=0 sets it to 0x0000000000000000000000000000000000000000000000000000000000000000
            // and r:= not(0) sets it to  0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
            r := not(0) 

            // And so not(2) will be truthy as well
        }
    }

    function negation2UsingNotUnsafe() external pure returns (uint256 result) {
        result = 1;

        assembly {
            if not(2) { // unsafe!
            // if we use iszero(2) , we get 1 as result!
                result := 2
            }
        }

        return result; // 2
    }

    function getMaximum(uint256 x, uint256 y) external pure returns (uint256 max) {
        assembly {
            if gt(x, y) {
                max := x
            } 
            // There is no else statement available in Yule, so need another if
            if gt(y, x) {
                max := y
            } 
        }
    }
}