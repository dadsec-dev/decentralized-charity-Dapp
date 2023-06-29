// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";
contract charity {

    using Counters for Counters.Counter;

    Counters.Counter public currentProjectId;


    struct project {
        address creator;
        address[] contributors;
        string projectName;
        string image;
        string description;
        uint256 goal;
        uint256 currentAmount;
        mapping (address => uint256) individualContribution;
        uint256 starttime;
        uint256 endtime;
        bool isStarted;
        bool isClosed;
    }

    mapping (uint256 => project) projects;

    uint256 public totalProjects;
    uint256 public PlatformFee = 0.01 ether;

    event projectCreated (uint256 projectId, address creator, uint256 goalAmount);
    event projectFunded (uint256 projectId, address contributor, uint256 amount);
    event projectClosed(uint256 projectId, bool isClosed);


    error projectEnded__();


    function createProject (string memory _image, string memory _projectName, string memory _description, uint256 _goal, uint256 _starttime, uint256 _endtime) public {
        require(msg.sender != address(0), "no 0 addr allowed");
        require(_goal > 0, "goal cant be 0");
        require(_starttime >= block.timestamp && _endtime > _starttime, "start tme must be a date in the future");
        
        currentProjectId.increment();
        
        uint _currentProjectId = currentProjectId.current();

        project storage project_ = projects[_currentProjectId];

        project_.creator = msg.sender;
        project_.projectName = _projectName;
        project_.image = _image;
        project_.description = _description;
        project_.goal = _goal;
        project_.starttime = _starttime;
        project_.endtime = _endtime;
        project_.isStarted = true;
        
        emit projectCreated(_currentProjectId, msg.sender, _goal);
    }

    function contribute(uint256 projectId_) public payable {
        
        project storage project_ = projects[projectId_];

        require(project_.isStarted == true, "not started");
        require(block.timestamp < project_.endtime, "ended" );

        if (project_.isStarted == true) {

            // project_.contributions = project_.contributions++;
            project_.contributors.push(msg.sender);
            project_.individualContribution[msg.sender] = msg.value;
            project_.currentAmount += msg.value;



        } else {
           revert projectEnded__();
        }



        

    }



}
