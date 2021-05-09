
contract SurveyList {
    
    uint public surveyCount = 0;
    uint public questionCount = 0;
    
    struct Question{
        
        uint id;
        bool completed;
        string content;
        string answer;
        string selectedAnswer;
        
    }
    
    struct Survey{
        
        uint id;
        Question question;


    }
    
    
    mapping(uint => Question) public questions;

    mapping(uint => Survey) public surveys;

    
    function createQuestion(string memory _content, string memory answer, string memory selectedAnswer) public {
        questions[questionCount] = Question(questionCount, false, _content, answer, selectedAnswer);
        questionCount++;

    }
    
    function createSurvey(uint id) public {
        Question memory question = questions[id];
        surveys[surveyCount] = Survey(surveyCount, question);
        surveyCount++;

        
    }
    
    function getQuestion(uint id) public view returns (string memory){
        Question memory question = questions[id];
        return (question.answer);
    }
    
    
    
}