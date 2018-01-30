pragma solidity ^0.4.18;

import "github.com/ethereum/solidity/std/mortal.sol";
//importing necessary functions for ownership.

contract SimpleWallet is mortal {

    mapping(address => Permission) myAddressMapping;
    event sendingtosomeone(address whosends, address whoissent, uint howmuchhecansend);

    struct Permission {
        bool isAllowed;
        uint maxTransferAmount;
    }

    function addAddressToSendersList(address permitted, uint maxTransferAmount) public onlyowner {
        myAddressMapping[permitted] = Permission(true, maxTransferAmount);
        sendingtosomeone(msg.sender, permitted, maxTransferAmount);
    }

    function sendFunds(address receiver, uint amountInWei) public {
        require(myAddressMapping[msg.sender].isAllowed);
        require(myAddressMapping[msg.sender].maxTransferAmount >= amountInWei);
        receiver.transfer(amountInWei);
    }
    
    function removesenders(address TheAddress){
        delete myAddressMapping[TheAddress];
    }



    function () public payable {}

}
