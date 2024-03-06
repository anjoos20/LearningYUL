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
}
