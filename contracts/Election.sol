pragma solidity >=0.5.0;

contract Election {
    
    struct Candidate{
        uint id;
        string name;
        uint voteCount;
    }

    // Keeping record of candidates (based on their unique IDs)
    mapping(uint=>Candidate) public candidates;

    // Keeping record of voters, i.e., storing the addresses of 
    // voters that have voted in the blockchain
    mapping(address=>bool) public voters; 

    // The following event will be trigerred whenever a vote is cast
    event votedEvent (
        uint indexed _candidateId
    );

    // Storing candidate count
    uint public candidatesCount;

    function addCandidate(string memory _name) private{
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function castVote(uint _cid) public{
        // require that they haven't voted before
        require(!voters[msg.sender]);

        // require that the candidate is authentic
        require(_cid>0 && _cid<=candidatesCount);

        // record the vote
        voters[msg.sender] = true;

        // update the vote count
        candidates[_cid].voteCount++;

        // trigger voted event
        emit votedEvent(_cid);
    }

    // Constructor
    constructor() public {
        addCandidate("Candidate #1");
        addCandidate("Candidate #2");
    }
}