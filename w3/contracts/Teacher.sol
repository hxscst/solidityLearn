pragma solidity >=0.4.22 <0.9.0;
import "./Score.sol";

	contract StudentScore{
	    uint totalScore;
	    uint studentCount;
	    address owner;
	    mapping(string => address) studentAddrMap;
	    mapping(string => uint) studentScoreMap;
	    event studentNotExistsEvent(string studentID);
	}

	modifier onlyOwner(){
        require(msg.sender == owner,"only owner can call this function");
        _;
    }

	function addStudentScore(string studentID, address student, uint score) public onlyOwner {    
        studentAddrMap[studentID] = student;
        studentScoreMap[studentID] = score;
        totalScore += score;
        studentCount ++;
    }
    
    function IScore(string studentID, uint score) public onlyOwner{
        if(!studentExists(studentID)) {
            studentNotExistsEvent(studentID);
            return;
        }
        totalScore -= studentScoreMap[studentID];
        studentScoreMap[studentID] = score;
        totalScore += score; 
    }


    function studentExists(string studentID) public view returns(bool){
        address student = Student(studentAddrMap[studentID]);
        if(student == 0x00){
            return false;
        }else{
            return true;
        }
    }


