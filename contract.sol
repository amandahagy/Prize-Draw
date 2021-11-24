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

    // luck algorithm
    function randomize() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, now, players)));
    }

    function chooseWinner() public restricted {           // manager modifier: restricted
        uint index = randomize() % players.length;       // luck algorithm
        players[index].transfer(address(this).balance);   // sends the money to the winner
        clean( );
    }

    modifier restricted() {
        require(msg.sender == contractManager);   // Only the manager can run chooseWinner()
        _;
    }

    // Cleaning it for a new round
    function clean() private {
        players = new address[](0);
    }

    // It runs automatically
    constructor() public {
        contractManager = msg.sender;  // contract manager = sender
    }
}