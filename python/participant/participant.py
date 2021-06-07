class Participant:
    def __init__(self, web3, contract):
        self.web3 = web3
        self.contract = contract

    def participantCount(self):
        print(self.contract.functions.getParticipantCount().call())

    def createParticipant(self, name, age):
        tx_hash = self.contract.functions.createParticipant(name, age).transact()
        self.web3.eth.waitForTransactionReceipt(tx_hash)
        print("Kullanıcı Oluşturuldu!")







