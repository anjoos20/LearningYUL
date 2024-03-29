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

    //  Actually, this gives an out of gas error
    // call to YulTypes.stringType errored: Error occurred: out of gas.
    


    function stringType() external pure returns(string memory) {
        // The string variable here is essentially on the memory heap
        string memory str = "";

        assembly {
            // But, here we are setting a ponter on the stack
            str := "hello"
        }
        // To avoid this error, we need to use bytes32 because bytes32 is stored on the stack
        return str;
    }

     function stringType1() external pure returns(string memory) {
        // We can only handle 32 bytes here. So longer strings doesnt work
        // Need to find a way around for this
        bytes32 str1 = "";

        assembly {
            str1 := "hello"
        }
        // To return as string convert in from bytes32 to string
        return string(abi.encode(str1));
    }

    function boolType() external pure returns(bool) {
        bool b;

        assembly {
            b := 0
        }

        return b;
    }

    function addressType() external pure returns(address) {
        address addr;

        assembly {
            // This is a 32 byte length in assembly and we are just setting the last bit
            addr := 1
        }
        // A valid solidity address with the last bit as 1
        //0x0000000000000000000000000000000000000001
        return addr;
    }
}