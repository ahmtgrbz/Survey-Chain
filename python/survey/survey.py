class Survey:

    def __init__(self, web3, contract):
        self.web3 = web3
        self.contract = contract
        self.question_count = self.contract.functions.getQuestionCount().call()


    def getSurveyCount(self):
        print(self.contract.functions.getSurveyCount().call())

    def getSurveyTitles(self):
        surveys = self.contract.functions.getAllSurveyTitles().call()
        for i in range(len(surveys)):
            print("{}. Anket: {}".format(i+1, surveys[0]))

    def createQuestion(self):
        question = input("Soruyu giriniz: ")
        answer = input("Cevapları ',' ile ayırarak giriniz: ").split(",")
        tx_hash = self.contract.functions.createQuestion(question, answer).transact()
        self.web3.eth.waitForTransactionReceipt(tx_hash)
        print("Soru oluşturuldu!")

    def createSurvey(self, survey):
        survey_content = input("Anket başlığını giriniz: ")
        soru_sayisi = int(input("Anketiniz kaç sorudan oluşacaktır?"))
        soru_havuzu = list()
        for i in range(1, soru_sayisi+1):
            print("{}. soru için; ".format(i))
            survey.createQuestion()
            soru_havuzu.append(self.question_count+(i-1))
        tx_hash = self.contract.functions.createSurvey(survey_content, soru_havuzu).transact()
        self.web3.eth.waitForTransactionReceipt(tx_hash)
        print("Anket oluşturuldu!")
