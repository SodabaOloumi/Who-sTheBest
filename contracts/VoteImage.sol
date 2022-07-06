// SPDX-License-Identifier: MIT
pragma solidity >=0.5.16 <0.9.0;


import "@openzeppelin/contracts/utils/Counters.sol";

contract VoteImage {

    struct Candidate {
        uint id;
        uint totalVote;
        string name;
        string imageHash;
        address candidateAddress;
    }
    using Counters for Counters.Counter;
    Counters.Counter private candidatesIds;

    mapping(address => Candidate) private candidates;
    mapping(uint=> address ) private accounts;
    mapping(address=> bool)private voter;

    event Voted(address indexed _candidateAddress, address indexed _voterAddress, uint _totalVote);
    event candidateCreated(address indexed canditateAddress, string name);
modifier candidateRegistred(address _address){
       require(candidates[_address].candidateAddress == _address ,
       "candidate not registred");
      _;
   }
modifier candidateNoExist(address _address){
       require(candidates[_address].candidateAddress != _address ,
       "candidate already registered");
      _;
   }

    function registerCandidate(string calldata _name, string calldata _imageHash) public candidateNoExist(msg.sender) {
        //check if candidate already registered
        require(msg.sender != address(0));
        
        candidatesIds.increment();
        uint candidateId = candidatesIds.current();
        address _address = address(msg.sender);
        Candidate memory newCandidate = Candidate(candidateId, 0, _name, _imageHash, _address);
        candidates[_address] = newCandidate;
        accounts[candidateId] = msg.sender;
        emit candidateCreated(_address, _name);
    }

      /* fetches all candidates */
    function getCandidates() public view returns ( Candidate[] memory) {
        uint itemCount = candidatesIds.current();

        Candidate[] memory candidatesArray = new Candidate[](itemCount);
        for (uint i = 0; i < itemCount; i++) {
            uint currentId = i + 1;
            Candidate memory currentCandidate = candidates[accounts[currentId]];
            candidatesArray[i] = currentCandidate;
        }
        return candidatesArray;
    }


    function vote(address _forCandidate) public candidateRegistred(_forCandidate){
        require(voter[msg.sender]== false, 'User is already vote');

        voter[msg.sender] = true;
        candidates[_forCandidate].totalVote += 1;
        
        emit Voted(_forCandidate, msg.sender, candidates[_forCandidate].totalVote);
    }

}