// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;


contract SurveyList {
    
    // These are for our models ids.
    uint public surveyCount = 0;
    uint public questionCount = 0;
    uint public ParticipantCount = 0;
    uint public AnswerCount = 0;
    address owner;

    // Survay Struct model
    struct Survey{
        uint id;
        string title;
        uint particapant_number;
        bool s_isfull;
    }
    
    // Question Struct model
    struct Question{
        uint id;
        string content;
        string[] options;
        bool q_isfull;
    }
    
    struct Participant{
        address p_address;
        string name;
        uint age;
        bool isfull;
    }
    
    struct Answer{
        uint answer_id;
        address who_participated;
        uint survey_id;
        string[] a_answer;
    }
   
    //------------events for creating question and survey------------ .
    event QuestionCreated(uint id, string _content, string[] answer);
    event SurveyCreated(uint id, string _title, uint particapant_number, bool s_isfull);
    event ParticipantCreated(address p_address, string name, uint age , bool isfull);

    
    //Creating mapping structure to keep data for question and survey.
    mapping(uint => Question) public questions;
    mapping(uint => Survey) public surveys;  
    mapping(address => Participant) public participants;
    mapping(uint => Answer) public answers;
    mapping(address => uint[]) public surveylist_of_participant;
    mapping(uint => uint[]) public questions_of_anysurvey;
    string[] public survey_titles;
    address[] participant_list;
    
   
    modifier ownerOnly {
      require(msg.sender == owner, "You are not a owner.");
      _;
    }
   
    modifier duplicatequestion(string memory _content, string[] memory answer){
       bool flag = true;
       for(uint i = 0; i <= questionCount; i++){
           if(keccak256(abi.encodePacked(questions[i].content)) == keccak256(abi.encodePacked(_content)) && answer.length ==  questions[i].options.length){
              flag = false;
           }
       }
       require(flag,"Duplicate Question, Please change the question.");
       _;
    }
   
   
   
   modifier duplicatesurvey(string memory  _title, uint[] memory Questionid){
       bool flag = true;
       for(uint i = 0; i <= surveyCount ; i++){
           if(keccak256(abi.encodePacked(surveys[i].title)) == keccak256(abi.encodePacked(_title)) && Questionid.length ==  questions_of_anysurvey[i].length){
              flag = false;
           }
       }
       require(flag,"Duplicate Question, Please change the question.");
       _;
    }
    
    //bugg problemi oluşturuyor.
    /*modifier questioncontrol(uint[] memory Questionid){
       bool flag = true;
       for(uint i = 0; i <= Questionid.length ; i++){
           if(questions[Questionid[i]].q_isfull == false ){
              flag = false;
           }
       }
       require(flag,"Question was not found,Please check questions ids.");
       _;
    }*/
    

    constructor(){
      owner = msg.sender;
   }
    
    
   
   
    //------------Creating functions------------
    function createQuestion(string memory _content, string[] memory answer) public ownerOnly duplicatequestion(_content,answer){
        require(bytes(_content).length > 0 && answer.length>0,"Please Fill In The Blanks");
        questions[questionCount] = Question(questionCount, _content, answer ,true);
        emit QuestionCreated(questionCount, _content, answer);
        questionCount++;
    }
    
    function createSurvey(string memory _title,uint[] memory Questionid) public ownerOnly duplicatesurvey(_title, Questionid) returns(uint) {
        require(bytes(_title).length > 0 && Questionid.length>0,"Please Fill In The Blanks");
        questions_of_anysurvey[surveyCount] = Questionid;
        surveys[surveyCount] = Survey(surveyCount,_title, 0, true);
        emit SurveyCreated(surveyCount, _title, 0, true);
        surveyCount++;
        survey_titles.push(_title);
        return surveyCount-1;

    }
    
    function joinTheSurvey(uint survey_id, string[] memory answer) public {
        require(answer.length>0,"Please Fill In The Blanks");
        require(participants[address(this)].isfull == true,"Please firstly create a participant account.");
        require(surveys[survey_id].s_isfull == true , "Survey not found, Please check Survey id.");
        Survey memory the_survey = surveys[survey_id];
        answers[AnswerCount] = Answer(AnswerCount, address(this), survey_id, answer);
        AnswerCount++;
        surveylist_of_participant[address(this)].push(surveyCount);
        the_survey.particapant_number +=1;

    }
    
    function createParticipant(string memory name, uint age) public{
        require(bytes(name).length > 0 && age > 0,"Please Fill In The Blanks");
        require(participants[address(this)].isfull == false,"You don't have participant account / You can't create duplicate account.");
        participants[address(this)] = Participant(address(this), name, age, true);
        emit ParticipantCreated(address(this), name, age ,true);
        participant_list.push(address(this));
    }
    
    
    
    //------------Getter functions------------
    function getSurvey(uint id) public view returns (string memory title, uint[] memory _survayquestions){
        
        Survey memory survey = surveys[id];
        return (survey.title, questions_of_anysurvey[id]);
    }
    
    
    function getQuestion(uint id) public view returns (string memory,string[] memory q_answers){
        
        Question memory question = questions[id];
        return (question.content,question.options);
    }
    
    function getParticipantCount() public view returns (uint){
        return participant_list.length;
    } 
    
    function getParticipantAddress() public view returns (address){
        return address(this);
    } 
    
    function getSurveyCount() public view returns (uint){
        return surveyCount;
    } 
    
    function getanswer(uint a_id) public view returns (string[] memory ans){
        ans = answers[a_id].a_answer;
        return ans;
    }
    
}