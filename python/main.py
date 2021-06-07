from web3 import Web3
import json

# Web3 Settings
ganache_url = "#"
web3 = Web3(Web3.HTTPProvider(ganache_url))
web3.eth.defaultAccount = web3.eth.accounts[0]

# Contract Settings
abi = json.loads("abi")
address = "contract address"
contract = web3.eth.contract(address=address, abi=abi)


def participantCount():
    print(contract.functions.getParticipantCount().call())
    
def createParticipant(name, age):
    tx_hash = contract.functions.createParticipant(name, age).transact()
    web3.eth.waitForTransactionReceipt(tx_hash)
    print("Kullanıcı Oluşturuldu!")

def main():
    while True:
        print("""
        1- Kaç Kullanıcı Olduğunu Öğren
        0- Çıkış
        """)

        deger = int(input("Hangi işlemi yapmak istediğinizi seçin: "))

        if(deger == 0):
            break
        elif(deger == 1):
            participantCount()
        elif(deger == 2):
            name = input("Lütfen isminizi giriniz: ")
            age = int(input("Lütfen yaşınızı giriniz: "))
            createParticipant(name, age)
        

if "__main__" == __name__:
    main()






