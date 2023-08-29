// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

contract Voting {
    // Define an Appropriate Data Type to Store Candidates
    struct Candidate {
        string name;
        uint256 voteCount;
    }

    // Define an Appropriate Data Type to Track If Voter has Already Voted
    mapping(address => bool) public hasVoted;

    // Store Candidates
    Candidate[] public candidates;

    // Adds New Candidate
    function addCandidate(string memory _name) public {
        require(bytes(_name).length > 0, "Candidate name cannot be empty");
        
        // Check if candidate with the same name already exists
        for (uint256 i = 0; i < candidates.length; i++) {
            require(keccak256(bytes(candidates[i].name)) != keccak256(bytes(_name)), "Candidate already exists");
        }
        
        candidates.push(Candidate({name: _name, voteCount: 0}));
    }

    // Removes Already Added Candidate
    function removeCandidate(uint256 _index) public {
        require(_index < candidates.length, "Invalid candidate index");
        require(candidates[_index].voteCount == 0, "Cannot remove candidate with votes");
        
        // Shift the array elements to remove the candidate at _index
        for (uint256 i = _index; i < candidates.length - 1; i++) {
            candidates[i] = candidates[i + 1];
        }
        candidates.pop();
    }

    // Retrieves All Candidates for Viewing
    function getAllCandidates() public view returns (Candidate[] memory) {
        return candidates;
    }

    // Allows Voter to Cast a Vote for a Single Candidate
    function castVote(uint256 _candidateIndex) public {
        require(_candidateIndex < candidates.length, "Invalid candidate index");
        require(!hasVoted[msg.sender], "Already voted");
        
        candidates[_candidateIndex].voteCount++;
        hasVoted[msg.sender] = true;
    }
}
