// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Charity {
    address payable public charityOwner;
    string public charityName;
    uint256 public requiredAmount;
    string public description;
    uint256 public minAmount;
    uint256 public amountCollected;
    string[] public tags;
    bool public isOpen;
    address [] public donors;
    uint256 public noOfDonors;

    constructor (
        address payable _charityowner, 
        string memory _charityname, 
        uint256 _requiredamount, 
        string memory _funddescription, 
        uint256 _minamount
        ) 
        {
            charityOwner = (_charityowner);
            charityName = _charityname;
            requiredAmount = _requiredamount;
            description = _funddescription;
            minAmount = _minamount;
            tags = new string[] (0);
            isOpen = true;
            noOfDonors = 0;
            donors = new address[] (0);
            amountCollected = 0;

    }

    function pay() external payable {
        if(msg.sender!=charityOwner)
        {
            if (msg.value < minAmount)
          {
            revert();
           }
          if (isOpen != true)
          {
            revert();
          }
          amountCollected += msg.value;
          bool contains=false;
         for (uint256 i=0; i<donors.length; i++)
         {
            if(donors[i]==msg.sender)
            {
                contains=true;
            }
            
          }
          if(contains==false)
          {
            donors.push(msg.sender);

          }
        
        
          if (amountCollected >= requiredAmount)
          {
            isOpen = false;
            charityOwner.transfer(address(this).balance);
          }

        }
        
    }

    function getCollectionPercentage() public view returns (uint256) {
        return ((amountCollected*100)/requiredAmount);
    
    
    }

    function addTags (string[] memory _s) public {
        for (uint256 i=0; i<_s.length; i++)
        {
            tags.push(_s[i]);
        }
    }
     

}