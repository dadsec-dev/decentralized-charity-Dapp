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
        uint256 votingStart;
        uint256 votingEnd;
        address[] pvoters;
        uint256 totalVotes;
        uint256 yes;
        uint256 no;

    }

    mapping(uint256 => proposal) proposalDetails;
    mapping (uint256 => mapping (address => bool) ) hasVoted;

    event proposalCreated(uint256 proposalId, string description, address proposer);
    event voteCasted(uint256 proposalId, address voter, bool _voteOption);

    error votingEnded();

    function setDAOtoken(address account) public {
        require(msg.sender == platform, "Unauthorized entity");
        charityToken = charityRewardToken(account);
    }

    function createProposal(string memory _text, uint256 _startTime, uint256 _endTime) public {
        require(charityToken.balanceOf(msg.sender) >= 1000, "Must hold DAO token");
        require(msg.sender != address(0), "invalid address");
        require(block.timestamp <= _startTime, "Must me a time in the future or currentTime");
        require(block.timestamp <= _endTime && _startTime < _endTime, "Invalid time setting");

        proposalID.increment();

        uint256 currentProposal = proposalID.current();

        proposal memory proposalCreation = proposalDetails[currentProposal];

        proposalCreation.proposer = msg.sender;
        proposalCreation.votingStart = _startTime;
        proposalCreation.votingEnd = _endTime;
        proposalCreation.description = _text;


    }


    function voteProposal(uint256 _proposalId, bool _voteOption) public {
        require(charityToken.balanceOf(msg.sender) >= 1000, "Must hold DAO token");
        require(block.timestamp <= proposalDetails[_proposalId].votingStart, "has not started");
        if (block.timestamp > proposalDetails[_proposalId].votingEnd) {
            revert votingEnded();
        }
        require(msg.sender != proposalDetails[_proposalId].proposer, "Proposer cannot vote");
        require(!hasVoted[_proposalId][msg.sender], "Address has voted");

        proposal storage _prop = proposalDetails[_proposalId];
        _prop.pvoters.push(msg.sender);
        _prop.totalVotes = _prop.totalVotes + 1;
        hasVoted[_proposalId][msg.sender] = true;

        if (_voteOption) {
            if (charityToken.balanceOf(msg.sender) >= 10000) {
                _prop.yes = _prop.yes + 10;
            } else if (charityToken.balanceOf(msg.sender) < 10000 && charityToken.balanceOf(msg.sender) >= 4998 ){
                _prop.yes = _prop.yes + 5;
            } else {
                _prop.yes = _prop.yes + 1;
            }
            
        } else {
            if (charityToken.balanceOf(msg.sender) >= 10000) {
                 _prop.no = _prop.no + 10;
            } else if (charityToken.balanceOf(msg.sender) < 10000 && charityToken.balanceOf(msg.sender) >= 4998 ){
                 _prop.no = _prop.no + 5;
            } else {
                _prop.yes = _prop.yes + 1;
            }
           
        }

        emit voteCasted(_proposalId, msg.sender, _voteOption);

    }

    function returnYes(uint256 _proposalId) public view returns (uint256) {
        return proposalDetails[_proposalId].yes;
    }

    function returnNo(uint256 _proposalId) public view returns (uint256) {
        return proposalDetails[_proposalId].no;
    }

    
}