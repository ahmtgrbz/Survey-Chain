// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;


contract SurveyList {
    
    // These are for our models ids.
    uint public surveyCount = 0;
    uint public questionCount = 0;
    uint public ParticipantCount = 0;
    
    
    // Survay Struct model
    struct Survey{
        uint id;
        string title;
        Question question;
    }
    
    // Question Struct model
    struct Question{
        uint id;
        bool completed;
        string content;
        string answer;
        string selectedAnswer;
    }
    
    struct Participant{
        address p_address;
        string name;
        uint age;
        uint joined_surveys;
    }
    
    address[] participant_list;
    
    //------------events for creating question and survey------------ .
    event QuestionCreated(uint id, bool completed, string _content, string answer, string selectedAnswer);
    event SurveyCreated(uint id, string title, Question question);
    event ParticipantCreated(address p_address, string name, uint age, uint joined_surveys);

    
    //Creating mapping structure to keep data for question and survey.
    mapping(uint => Question) public questions;
    mapping(uint => Survey) public surveys;
    mapping(address => Participant) public participants;

    //------------Creating functions------------
    function createQuestion(string memory _content, string memory answer, string memory selectedAnswer) public {
        questions[questionCount] = Question(questionCount, false, _content, answer, selectedAnswer);
        emit QuestionCreated(questionCount, false,_content, answer, selectedAnswer);
        questionCount++;
    }
    
    function createSurvey(uint id, string memory title) public {
        Question memory question = questions[id];
        surveys[surveyCount] = Survey(surveyCount,title, question);
        emit SurveyCreated(surveyCount, title, question);
        surveyCount++;
    }
    
    function createParticipant(string memory name, uint age) public{
        
        participants[address(this)] = Participant(address(this), name, age, ParticipantCount);
        emit ParticipantCreated(address(this), name, age, ParticipantCount);
        participant_list.push(address(this));
    }
    
    
    //------------Getter functions------------
      function getSurvey(uint id) public view returns (string memory){
        Survey memory survey = surveys[id];
        return (survey.title);
    }
    
    
    function getQuestion(uint id) public view returns (string memory){
        Question memory question = questions[id];
        return (question.answer);
    }
    
    function getParticipantCount() public view returns (uint c){
        return participant_list.length;
    } 
    
}