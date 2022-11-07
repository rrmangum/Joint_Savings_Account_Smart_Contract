pragma solidity ^0.5.0;

// Define a new contract
contract JointSavings {
    // Define variables
    address payable accountOne;
    address payable accountTwo;
    address public lastToWithdraw;
    uint256 public lastWithdrawAmount;
    uint256 public contractBalance;

    // Define a withdraw function
    function withdraw(uint256 amount, address payable recipient) public {
        // Checks if the recipient is equal to either accountOne or accountTwo.
        // The require statement returns the text "You don't own this account!" if it does not.
        require(
            recipient == accountOne || recipient == accountTwo,
            "You don't own this account!"
        );

        // Checks if the balance is sufficient to accomplish the withdraw operation.
        // If there are insufficient funds, the text `Insufficient funds!` is returned.
        require(contractBalance >= amount, "Insufficient funds!");

        // Checks if the lastToWithdraw is not equal to to recipient.
        // If lastToWithdraw is not equal, then set it to the current value of recipient.
        if (lastToWithdraw != recipient) {
            lastToWithdraw = recipient;
        }

        // Call the transfer function of the recipient and pass it the amount to transfer as an argument.
        recipient.transfer(amount);

        // Set  lastWithdrawAmount equal to amount
        lastWithdrawAmount = amount;

        // Call the contractBalance variable and set it equal to the balance of the contract
        contractBalance = address(this).balance;
    }

    // Define a public payable function.
    function deposit() public payable {
        // Call the contractBalance variable and set it equal to the balance of the contract.
        contractBalance = address(this).balance;
    }

    // Define a public function that receives two address payable arguments
    function setAccounts(address payable account1, address payable account2)
        public
    {
        // Set the values of accountOne and accountTwo to account1 and account2 respectively.
        accountOne = account1;
        accountTwo = account2;
    }

    // Default fallback function
    function() external payable {}
}
