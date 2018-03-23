pragma solidity ^0.4.18;

contract Owned {
    address owner;
    
    function Owned() public {
        owner = msg.sender;
    }
    
   modifier onlyOwner {
       require(msg.sender == owner);
       _;
   }
}

contract University is Owned {
    
    struct Professor {
        uint id;
        string name;
        bool can_edit;
    }
    
    struct Student {
        uint id;
        string name;
        bool view_private_info;
        uint marks;
    }
    
    mapping (address => Professor) professors;
    address[] public professorAccts;
    
    mapping (address => Student) students;
    address[] public studentsAccts;
    
    
    function setProfessor(address _address, uint _id, string _name, bool _can_edit) onlyOwner public {
        
        
        var professor = professors[_address];
        
        professor.id = _id;
        professor.name = _name;
        professor.can_edit = _can_edit;
        
        professorAccts.push(_address) -1;
        
    }
    
    function setStudent(address _address, uint _id, string _name, bool _view_private_info, uint _marks) public {
        
        //either owner or professor can add student info
        bool condtn = false;
        
        if(msg.sender == owner){
            condtn = true;
        }
        
        if(professors[msg.sender].can_edit == true){
            condtn = true;
        }
        
        require(condtn == true);
        
        //now insert new student details
        var student = students[_address];
        
        student.id = _id;
        student.name = _name;
        student.view_private_info = _view_private_info;
        student.marks = _marks;
        
        studentsAccts.push(_address) -1;
        
    }
    
    //functions below to edit professor and student
    //owner can only edit professor info
    //owner and professor can edit student info
    function editProfessor(address _address, uint _id, string _name, bool _can_edit) onlyOwner public {
        
        var professor = professors[_address];
        
        //give number as 0 and blank string so that it won't show anything
        professor.id = _id;
        professor.name = _name;
        professor.can_edit = _can_edit;
        
    }
    
    function editStudent(address _address, uint _id, string _name, bool _view_private_info, uint _marks) public {
        
        bool condtn = false;
        
        if(msg.sender == owner){
            condtn = true;
        }
        
        if(professors[msg.sender].can_edit == true){
            condtn = true;
        }
        
        require(condtn == true);
        
        //now insert new student details
        var student = students[_address];
        
        student.id = _id;
        student.name = _name;
        student.view_private_info = _view_private_info;
        student.marks = _marks;
        
    }
    
    function getProfessors() view public returns(address[]) {
        return professorAccts;
    }
    
    function getProfessor(address _address) view public returns (uint, string) {
        return (professors[_address].id, professors[_address].name);
    }
    
    function getStudents() view public returns(address[]){
        return studentsAccts;
    }
    
    function getStudent(address _address) view public returns (uint, string) {
        return (students[_address].id, students[_address].name);
    }
    
    function getStudentWithPrivateInfo(address _address) view public returns (uint, string, uint) {
        require(students[_address].view_private_info == true);
        return (students[_address].id, students[_address].name, students[_address].marks);
    }
    
    function countProfessors() view public returns (uint) {
        return professorAccts.length;
    }
    
    function countStudents() view public returns (uint) {
        return studentsAccts.length;
    }
    
}