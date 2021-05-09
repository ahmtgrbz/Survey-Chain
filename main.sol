
contract SurveyList {
    
    uint public surveyCount = 0;
    uint public questionCount = 0;
    
    struct Question{
        
        uint id;
        bool completed;
        string content;
        string[] answer;
        string selectedAnswer;
        
    }
    
    struct Survey{
        
        uint id;
        Question[] question;
    
    }
    
    
    
    mapping(uint => Survey) public surveys;
    mapping(uint => Question) public questions;

    
    function createQuestion(string memory _content, string[] memory answer, string memory selectedAnswer) public {
        questionCount++;
        questions[questionCount] = Question(questionCount, false, _content, answer, selectedAnswer);
        
    }
    
    function createSurvey(Question[] memory Question1) public {
        surveyCount++;
        surveys[surveyCount] = Survey(surveyCount, Question1);
        
    }
    
    
    
}