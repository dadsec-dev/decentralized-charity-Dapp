// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "./charityRewardToken.sol";

contract charityDAO {

    using Counters for Counters.Counter;
    Counters.Counter public proposalID;

    charityRewardToken private charityToken;
    uint256 public proposalCount;
    address public platform;

    uint256 qualifyingNoOfVotes;

    struct proposal {
        address proposer;
        string description;
        uint256 votingPeriod;
        address[] pvoters;
        uint256 totalVotes;

    }

    mapping(uint256 => proposal) proposalDetails;
    mapping (uint256 => mapping (address => bool) ) hasVoted;

    event proposalCreated(uint256 proposalId, string description, address proposer);
    event voteCasted(uint256 proposalId, address voter);

    function setDAOtoken(address account) public {
        require(msg.sender == platform, "Unauthorized entity");
        charityToken = charityRewardToken(account);
    }

    function createProposal(string memory _text, uint256 _votingPeriod) public {
        require(charityToken.balanceOf(msg.sender) >= 1000, "Must hold DAO token");
        require(msg.sender != address(0), "invalid address");

        proposalID.increment();

        uint256 currentProposal = proposalID.current();

        proposal memory proposalCreation = proposalDetails[currentProposal];

        proposalCreation.proposer = msg.sender;
        proposalCreation.votingPeriod = _votingPeriod;
        proposalCreation.description = _text;


    }


    function voteProposal(uint256 proposalId) public {
        require(charityToken.balanceOf(msg.sender) >= 1000, "Must hold DAO token");
        require(msg.sender != proposalDetails[proposalId].proposer, "Proposer cannot vote");

        proposal storage _prop = proposalDetails[proposalId];
        _prop.pvoters.push(msg.sender);
        _prop.totalVotes = _prop.totalVotes + 1;

    }
}