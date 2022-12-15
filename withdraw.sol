// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract bank{
    mapping(address=>uint)private _balances;
    address public   owner;
    event logDepositeMade(address  accountHolder,uint amount);
    constructor() public {
        owner=msg.sender;
        emit logDepositeMade(msg.sender,1000);
    }
    function kill() public 
    {
        selfdestruct(payable(msg.sender));
    }
    function deposit() public payable returns (uint)
    {
        require((_balances[msg.sender]+msg.value)>_balances[msg.sender] && msg.sender!=address(0));
        _balances[msg.sender]+=msg.value;
        emit logDepositeMade(msg.sender,msg.value);
        return _balances[msg.sender];
    }
    function withdraw(uint withdrawAmount) public returns (uint)
    {
       require(_balances[msg.sender]>=withdrawAmount);
       require(msg.sender!=address(0));
       require(_balances[msg.sender]>0);
       _balances[msg.sender]-=withdrawAmount;
       payable(msg.sender).transfer(withdrawAmount);
       emit logDepositeMade(msg.sender,withdrawAmount);
       return _balances[msg.sender];
    }
    function viewBalance() public view returns(uint)
    {
        return _balances[msg.sender];
    }
}