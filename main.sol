// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;


contract SurveyList {
    
    // These are for our models ids.
    uint public surveyCount = 0;
    uint public questionCount = 0;
    uint public ParticipantCount = 0;
    uint public AnswerCount = 0;

    
    // Survay Struct model
    struct Survey{
        uint id;
        string title;
        uint particapant_number;
    }
    
    // Question Struct model
    struct Question{
        uint id;
        string content;
        string answer;
        
        
    }
    
    struct Participant{
        address p_address;
        string name;
        uint age;
    }
    
    struct Answer{
        uint answer_id;
        address who_participated;
        uint survey_id;
        string a_answer;// bir answerda birden fazla cevap olabilir
    }
    
    string[] public survey_titles;
    address[] participant_list;
    mapping(address => uint[]) public surveylist_of_participant;
    mapping(uint => uint[]) public questions_of_anysurvey;
    
    
    //------------events for creating question and survey------------ .
    event QuestionCreated(uint id, string _content, string answer);
    event SurveyCreated(uint id, string title, uint particapant_number);
    event ParticipantCreated(address p_address, string name, uint age);

    
    //Creating mapping structure to keep data for question and survey.
    mapping(uint => Question) public questions;
    mapping(uint => Survey) public surveys;  // kaç anket olduğunu bilmiyoruz ki nasıl topluca dönecek array
    mapping(address => Participant) public participants;
    mapping(uint => Answer) public answers; //map burada
//bir map daha gere
    


    //------------Creating functions------------
    function createQuestion(string memory _content, string memory answer) public {
        questions[questionCount] = Question(questionCount, _content, answer);
        emit QuestionCreated(questionCount, _content, answer);
        questionCount++;
    }
    
    function createSurvey(uint[] memory Questionid, string memory title) public returns(uint){
        questions_of_anysurvey[surveyCount] = Questionid;
        surveys[surveyCount] = Survey(surveyCount,title, 0);
        emit SurveyCreated(surveyCount, title, 0);
        surveyCount++;
        survey_titles.push(title);
        return surveyCount-1;

    }
    
    function joinTheSurvey(uint survey_id, string memory answer) public { //kullanıcı ankete katılır
        Survey memory the_survey = surveys[survey_id];
        answers[AnswerCount] = Answer(AnswerCount, address(this), survey_id, answer);
        AnswerCount++;
        surveylist_of_participant[address(this)].push(surveyCount);
        the_survey.particapant_number +=1;

    }
    
    function createParticipant(string memory name, uint age) public{
        
        participants[address(this)] = Participant(address(this), name, age);
        emit ParticipantCreated(address(this), name, age);
        participant_list.push(address(this));
    }
    
    
    //------------Getter functions------------
    function getSurvey(uint id) public view returns (string memory title, uint soru1, uint soru2){
        Survey memory survey = surveys[id];
        return (survey.title, questions_of_anysurvey[id][0], questions_of_anysurvey[id][1]);
    }
    
    
    function getQuestion(uint id) public view returns (string memory){
        Question memory question = questions[id];
        return (question.content);
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
    
}