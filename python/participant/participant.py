class Participant:
    def participantCount(self, contract):
        print(contract.functions.getParticipantCount().call())

    def createParticipant(self, web3, contract, name, age):
        tx_hash = contract.functions.createParticipant(name, age).transact()
        web3.eth.waitForTransactionReceipt(tx_hash)
        print("Kullanıcı Oluşturuldu!")







