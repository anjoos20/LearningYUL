// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.19;

/* Why do we need the memory for:
*--------------------------------
* For Returning values 
* For Setting arguments
* Getting values from external calls
* To be able to revert with a specific string
* For Logging or emitting logs
* For deploying new contracts
* Use keccak256 function

NOTE
----

* With solidity, there is no garbage collection for memory
* Memory is arranged in 32 byte sequences
* Only 4 instructions to know: mload, mstore, mstore8 and msize
*/

contract YulMemory {
//mstore function takes the location that you want to start saving the data in memory from-location 
// here, from location 0, I am going to save my data which is a s2 byte word 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
    function mstoreExample() public pure {
        assembly {
            // moves a 32byte word to memory location 0x0 
            // 0x0 to 0x1F is the first 32 bytes of memory and the next starts at 0x20
            mstore(0x0, 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)
            // Moves a 1 byte word to memory location 0x1
            mstore(0x0, 0x0) // reset
            // Even though its just 1 byte, it clears out the whole memory
            // Since it gets only 31 bytes in the first memory, it takes up 1 more byte in the next memory 
            // starting 0x20
            // Check the screenshots of the remix debug
            mstore(0x1, 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)
            //Because mstore works with 32 bytes, it puts leading zeros infront of 2 i.e 2 prefixed with all zeros           
            mstore(0x0, 0x2)
        }
    }
// mstore8 only modifies a single byte
    function mstore8Example() public pure {
        assembly {
            
            mstore(0x0, 0x2)
            //At 0x0:   0x0000000000000000000000000000000000000000000000000000000000000002
            mstore8(0x0, 0x7)
            //At 0x0:  0x0700000000000000000000000000000000000000000000000000000000000002
            mstore(0x0, 0x7)
            // AT 0x0: 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
        }
    }
    
}
