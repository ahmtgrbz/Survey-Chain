from web3 import Web3
import json
from participant.participant import Participant
from survey.survey import Survey

# Web3 Settings
ganache_url = "#"
web3 = Web3(Web3.HTTPProvider(ganache_url))
web3.eth.defaultAccount = web3.eth.accounts[0]

# Contract Settings
abi = json.loads("#")
address = "#"
contract = web3.eth.contract(address=address, abi=abi)



def main():
    while True:
        print("""
        1- Kaç Kullanıcı Olduğunu Öğren
        2- Kullanıcı Oluştur
        3- Kaç Anket Olduğunu Öğren
        0- Çıkış
        """)

        deger = int(input("Hangi işlemi yapmak istediğinizi seçin: "))

        if(deger == 0):
            break
            
        elif(deger == 1):
            participant = Participant(web3, contract)
            participant.participantCount()

        elif(deger == 2):
            participant = Participant(web3, contract)
            participant.createParticipant()
        
        elif(deger == 3):
            survey = Survey(web3, contract)
            survey.getSurveyCount()

if "__main__" == __name__:
    main()







