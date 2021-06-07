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
        

if "__main__" == __name__:
    main()






