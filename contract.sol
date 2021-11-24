pragma solidity 0.4.24; // versions < 0.4.24 have constructor() issues

contract Draw {
    address private contractManager;  // variable
    address[] private players;    // variable

    function getPlayers() public view returns (address[]){
        return players;
    }

    function getContractManager() public view returns (address) {
        return contractManager;
    }

    function getBalance() public view returns (uint)
    {
        return address(this).balance;
    }

    function join() public payable {       // Pay for joining
        require(msg.value >= 1 ether);  // At least 1 ether is required as payment
        players.push(msg.sender);         // Saves the player address if he pays for it
    }
}