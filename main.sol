// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;


contract SurveyList {
    
    address owner;
    string[] public survey_titles;
    address[] participant_list;
    
    // These are for our models' ids.
    uint public surveyCount = 0;
    uint public questionCount = 0;
    uint public ParticipantCount = 0;
    uint public AnswerCount = 0;
    

    // ---------- These are our models. Such as Survey, Question, Participant, Answer ----------
    struct Survey{
        uint id;
        string title;
        uint particapant_number;
        bool s_isfull;
    }
    
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
    
   
    // ---------- Events for creating question, survey and participant ----------
    event QuestionCreated(uint id, string _content, string[] answer);
    event SurveyCreated(uint id, string _title, uint particapant_number, bool s_isfull);
    event ParticipantCreated(address p_address, string name, uint age , bool isfull);

    
    // ---------- Mappings to save relevant data for Question, Survey, Participant and Answer ----------
    mapping(uint => Question) public questions;
    mapping(uint => Survey) public surveys;  
    mapping(address => Participant) public participants;
    mapping(uint => Answer) public answers;
    
    // ---------- Mappings to save questions for survey and surveylist for participant ----------
    mapping(address => uint[]) public surveylist_of_participant;
    mapping(uint => uint[]) public questions_of_anysurvey;
    
    
    constructor(){
      owner = msg.sender;
    }
   
    modifier ownerOnly {
      require(msg.sender == owner, "You are not an owner.");
      _;
    }
    
    
    
    modifier joinedBefore(address _address, uint survey_id){
        bool flag = true;
        for(uint i = 0; i<surveylist_of_participant[_address].length; i++){
            if(surveylist_of_participant[_address][i] == survey_id){
                flag = false;
            }
        }
        require(flag, "You have already joined this survey before!");
        _;
    }
    
    
   
    modifier createdQuestionBefore(string memory _content, string[] memory answer){
       bool flag = true;
       for(uint i = 0; i <= questionCount; i++){
           if(keccak256(abi.encodePacked(questions[i].content)) == keccak256(abi.encodePacked(_content)) && answer.length ==  questions[i].options.length){
              flag = false;
           }
       }
       require(flag, "This question created before!");
       _;
    }
   
   
   
   modifier createdSurveyBefore(string memory _title, uint[] memory Questionid){
       bool flag = true;
       for(uint i = 0; i <= surveyCount ; i++){
           if(keccak256(abi.encodePacked(surveys[i].title)) == keccak256(abi.encodePacked(_title)) && Questionid.length ==  questions_of_anysurvey[i].length){
              flag = false;
           }
       }
       require(flag, "This survey created before!");
       _;
    }
    

   
    // ---------- Creating functions ----------
    function createQuestion(string memory _content, string[] memory answer) public ownerOnly createdQuestionBefore(_content,answer){
        require(bytes(_content).length > 0 && answer.length>0, "Please Fill In The Blanks");
        questions[questionCount] = Question(questionCount, _content, answer ,true);
        emit QuestionCreated(questionCount, _content, answer);
        questionCount++;
    }
    
    function createSurvey(string memory _title,uint[] memory Questionid) public ownerOnly createdSurveyBefore(_title, Questionid) returns(uint) {
        require(bytes(_title).length > 0 && Questionid.length>0, "Please Fill In The Blanks");
        questions_of_anysurvey[surveyCount] = Questionid;
        surveys[surveyCount] = Survey(surveyCount,_title, 0, true);
        emit SurveyCreated(surveyCount, _title, 0, true);
        surveyCount++;
        survey_titles.push(_title);
        return surveyCount-1;

    }
    
    function joinTheSurvey(uint survey_id, string[] memory answer) public joinedBefore(address(this), survey_id) {
        require(answer.length>0, "Please Fill In The Blanks");
        require(participants[address(this)].isfull == true, "To join survey, you should log in first.");
        require(surveys[survey_id].s_isfull == true, "Given survey id not found!");
        Survey memory the_survey = surveys[survey_id];
        answers[AnswerCount] = Answer(AnswerCount, address(this), survey_id, answer);
        AnswerCount++;
        surveylist_of_participant[address(this)].push(survey_id);
        the_survey.particapant_number +=1;

    }
    
    function createParticipant(string memory name, uint age) public{
        require(bytes(name).length > 0 && age > 0, "Please Fill In The Blanks");
        require(participants[address(this)].isfull == false, "You don't have participant account / You can't create duplicate account.");
        participants[address(this)] = Participant(address(this), name, age, true);
        emit ParticipantCreated(address(this), name, age ,true);
        participant_list.push(address(this));
    }
    
    
    
    // ---------- Getter functions ----------
    
    function getSurvey(uint id) public view returns (string memory title, uint[] memory _survayquestions){
        Survey memory survey = surveys[id];
        return (survey.title, questions_of_anysurvey[id]);
    }
    
    
    function getQuestion(uint id) public view returns (string memory, string[] memory q_answers){
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
    
    function getAnswer(uint a_id) public view returns (string[] memory ans){
        ans = answers[a_id].a_answer;
        return ans;
    }
    
}