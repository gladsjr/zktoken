// SPDX-License-Identifier: MIT 

import "verifier.sol";

pragma solidity ^0.8.0;

contract zktoken
{
    address owner;
    Verifier verifier;
    mapping (bytes32 => bool) isUtxoHash;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor ()
    {
        owner = msg.sender;
        verifier = new Verifier();
    }

    function mint(uint256 _value) public onlyOwner 
    {

    }

    function transfer(bytes3 proof, bytes32 senderUtxoHash, bytes32 receiverUtxoHash, bytes32 ) public 
    {
        require(isUtxoHash[senderUtxoHash], "The UTXO hash presented is not valid");

        /**
            Verify that
            a) Both utxoHashs are hashs of a valid UTXO which if formed of a public address (utxoAddr) 
                and a value (utxoValue)
            b) Sender knows public address' private key of senderUtxo
            c) senderUtxoValue - receiverUtxoValue >= 0
            d) receiverUtxoValue > 0
        */



        // Mark origin UTXOHash as spent
        isUtxoHash[senderUtxoHash] = false;

        // Mark the other UTXOHash as not spent (as UTXO, indeed)
        isUtxoHash[receiverUtxoHash] = true;
        isUtxoHash[changeUtxoHash] = true; 
    }
}