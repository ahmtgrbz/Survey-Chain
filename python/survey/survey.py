class Survey:
    def __init__(self, web3, contract):
        self.web3 = web3
        self.contract = contract
        self.question_count = self.contract.functions.getQuestionCount().call()


    def getSurveyCount(self):
        print(self.contract.functions.getSurveyCount().call())