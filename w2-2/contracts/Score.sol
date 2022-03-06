pragma solidity >=0.4.22 <0.9.0;

	contract Student{
	    string studentID;
	    string studentName;
	    address owner;
	}

    constructor(string _studentID, string _stdentName) public{
		studentID = _studentID;
		studentName = _stdentName;
		owner = msg.sender;
	}

    modifier onlyOwner(){
    	require(msg.sender == owner,"only owner can call this function");
    	_;
	}

    function getStudentIDandName() public constant returns(string,string) {
    	return (studentID,studentName);
    }

    function setStudentIDandName(string _studentID,string _studentName) public onlyOwner {
    	studentID = _studentID;
    	studentName = _studentName;
    }