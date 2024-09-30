// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.27;

import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract Create {
    using Counters for Counters.Counter;
    Counters.Counter public _voterId;
    Counters.Counter public _candidateId;

    address public votingOrganizer;

    // CANDIDATE DATA
    struct Candidate {
        uint256 candidateId;
        uint256 age;
        string name;
        string image;
        uint256 voteCount;
        address _address;
        string ipfs;
    }

    event CreateCandidate(
        uint256 indexed candidateId,
        uint256 age,
        string name,
        string image,
        uint256 voteCount,
        address _address,
        string ipfs
    );

    address[] public candidateAddress;
    mapping(address => Candidate) public candidates;

    //========== END OF CANDIDATE DATA ==========//

    // VOTER DATA
    address[] public votedVoters;
    address[] public votersAddress;
    mapping(address => Voter) public voters;

    struct Voter {
        uint256 voter_voterId;
        //uint256 voter_age;
        string voter_name;
        string voter_image;
        uint256 voter_authorised;
        address voter_address;
        bool voter_voted;
        uint256 voter_vote;
        string voter_ipfs;
    }

    event VoterCreated(
        uint256 indexed voter_voterId,
        uint256 voter_age,
        string voter_name,
        string voter_image,
        uint256 voter_authorised,
        address voter_address,
        bool voter_voted,
        uint256 voter_vote,
        string voter_ipfs
    );

    //========== END OF VOTER DATA ==========//

    constructor() {
        votingOrganizer = msg.sender;
    }

    function setCandidate(
        address _address,
        string memory _age,
        string memory _name,
        string memory _image,
        string memory _ipfs
    ) public {
        require(
            votingOrganizer == msg.sender,
            "Only Authorised Organizer Can Register A Candidate!"
        );
        _candidateId.increment();

        uint256 idNumber = _candidateId.current();

        Candidate storage candidate = candidates[_address];
        candidate.age = _age;
        candidate.name = _name;
        candidate.candidateId = idNumber;
        candidate.image = _image;
        candidate.voteCount = 0;
        candidate._address = _address;
        candidate.ipfs = _ipfs;

        candidateAddress.push(_address);

        emit CreateCandidate(
            idNumber,
            _name,
            _age,
            _image,
            candidate.voteCount,
            _address,
            _ipfs
        );
    }
}
