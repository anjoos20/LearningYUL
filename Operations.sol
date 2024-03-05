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
}