pragma solidity ^0.8.19;

contract BackdooredContract {
    mapping(address => uint256) public balances;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Not enough balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    // No access control. Updates any user’s balance. Has no onlyOwner or access control modifier.
    function setBalance(address user, uint256 amount) public {
        balances[user] = amount;
    }

    // No ownership check. Transfers all funds to any caller.
    function drainAll() public {
        payable(msg.sender).transfer(address(this).balance);
    }
}
