class Participant:
    def __init__(self, web3, contract):
        self.web3 = web3
        self.contract = contract

    def participantCount(self):
        print(self.contract.functions.getParticipantCount().call())

    def getAllParticipant(self):
        address_list = self.contract.functions.getAllParticipantAddresses().call()
        for i in range(len(address_list)):
            print("{}. Kullanıcı: Address= {}, Name= {}".format(i + 1,
                                                                address_list[i],
                                                                self.contract.functions.participants(address_list[i]).call()[
                                                                    1]))

    def createParticipant(self):
        name = input("Lütfen isminizi giriniz: ")
        age = int(input("Lütfen yaşınızı giriniz: "))

        tx_hash = self.contract.functions.createParticipant(name, age).transact()
        self.web3.eth.waitForTransactionReceipt(tx_hash)
        print("Kullanıcı Oluşturuldu!")







