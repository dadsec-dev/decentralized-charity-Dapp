// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "../interfaces/interface.sol";

contract charityRewardToken is ERC20, Ownable {
    address private mintCaller;
    uint256 private MAX_SUPPLY;
    address public platform = 0x35064FAcBD34C7cf71C7726E7c9F23e4650eCA10;

    constructor() ERC20("Charity Token", "CT") {
        MAX_SUPPLY = 10_000_000_000_000 * (10 ** decimals());
    }

    modifier onlyMintCaller() {
        require(
            msg.sender == mintCaller || msg.sender == platform,
            "Only the mint caller can call this function."
        );
        _;
    }

    function setMintCaller(address _mintCaller) public {
        require(msg.sender == platform, "Unauthorized entity");
        mintCaller = _mintCaller;
    }

    function mint(address account, uint256 amount) public  onlyMintCaller{
        require(totalSupply() + amount <= MAX_SUPPLY, "MAX SUPPLY REACHED");
        super._mint(account, amount);
    }


    function decimals() public view virtual override returns (uint8) {
        return 18; // Or any other number of decimals you want to use
    }

    function getMaxSupply() public view returns (uint256) {
        return MAX_SUPPLY;
    }

    

}