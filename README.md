# Survey-Chain

This project has been prepared within the scope of the Ceng3550 - Decentralized Systems and Applications course to increase the reliability of the questionnaires. Blockchain technology, an innovative solution, was used to overcome the reliability problem. Ethereum infrastructure, a popular blockchain infrastructure, was used in the development of the project.

## Medium Article
[Click here.](https://medium.com/@muratgun545/ethereum-based-survey-application-with-flutter-2d99a1e36e64) 

## Project Description
Today, many tools are used to get feedback from people. Undoubtedly, one of the most used tools among these tools is survey applications, as they can receive the user’s feedback directly. For this reason, surveys are preferred by many institutions and organizations. However, the results of most of the surveys conducted today can be manipulated sometimes by the participants and sometimes by the organizers. For this reason, reliability and transparency are vital for survey applications. With Blockchain technology, it is aimed to eliminate the reliability and transparency problems in many areas. Survey applications can also be developed with blockchain technology, thus providing a more reliable environment.

Our aim is to produce an innovative and reliable solution by combining blockchain technology and surveys.

## Team Members(sorted by name)

<table>
  <tr>
    <td align="center"><a href="https://github.com/ahmtgrbz"><img src="https://avatars0.githubusercontent.com/u/44843548?s=460&v=4" width="100px;" alt=""/><br /><sub><b>Ahmet GÜRBÜZ</b></sub></a><br /><br /><sub><b>Smart Contract Developer</b></sub></a><br /></a></td>
    <td align="center"><a href="https://github.com/desxz"><img src="https://avatars1.githubusercontent.com/u/63814984?s=460&u=e54733ff64da68c0013cff94fb45ca81272802de&v=4" width="100px;" alt=""/><br /><sub><b>Murat GUN</b></sub></a><br /><br /><sub><b>Mobile Application Developer</b></sub></a><br /></a></td>
    <td align="center"><a href="https://github.com/onur-duman"><img src="https://avatars1.githubusercontent.com/u/44534189?s=460&u=74a6216bbebfee1609e631f3ce80ab8241bdfc6a&v=4" width="100px;" alt=""/><br /><sub><b>Onur DUMAN</b></sub></a><br /><br /><sub><b>Smart Contract Developer</b></sub></a><br /></a></td>
  </tr>
</table>

## System Design

As seen in below figure, the contract is first developed and put into service by us. On the user side, there are both participants and institutions. Our users can access the system from the interfaces provided to them and interact with the services offered to them. In our application, not every survey is in the form of a contract. The contract developed by the developer team is deployed by the institution. After this step, each survey continues by adding it to the existing contract. In this way, even if the company does not have technical knowledge about the contract, this technology can easily be used. As we mentioned before, our contract can be broadcast on all existing ethereum-based networks. 

![System Design](https://github.com/ahmtgrbz/Survey-Chain/blob/main/design/System%20Design.png)

## System Usage
Our Survey Chain project consists of 3 parts; User Interface, Contract, Blockchain Network. On the user interface side, a mobile application has been developed for the participants. Dart language and Flutter framework were used in mobile application development. On the corporate side, a backend service has been written with python and the user interface runs continue. On the mobile application screen, users first enter their information. This information matches their wallet addresses on the network. In this way, one time voting is provided for the same poll from a wallet address. After the user enters his information, he sees the list of active surveys on the network. At this point, he chooses a survey of his choice. It is displayed to the user along with the selected survey questions. The user answers the questions by choosing the options they want and confirms their answers. Responses are sent on the contract after confirmation. The contract receives and saves the incoming results. The application lifecycle for the user ends here. The institution uses the admin panel to create the survey. The panel includes functions for creating or interacting with existing polls. With the help of these functions, it first creates questions. Then institution adds the questions it created to the survey. Then it publishes the survey. In this panel, you can access the answers to the survey and some statistics about the survey live. 

Below figure shows how our users, that is, both the institution and our participants, establish access with the contract. On the institution side; The institution can access the previously published contract through the interface and use the services allowed. One of these services and the most important one is actually creating a survey, as seen in the figure. The created questionnaire is forwarded to the contract thanks to the web3 framework. Thus, the specified survey is added to the survey pool. On the participant side; As in the institution, the interaction takes place through the user interface. But these platforms are separated from each other. Our participants access the application through a mobile application. Register first via mobile app. Afterwards, they can participate in the surveys that interest them from the surveys in the pool.

![System Usage](https://github.com/ahmtgrbz/Survey-Chain/blob/main/design/System%20Usage.png)

## Mobile Application UI
![Mobile Application UI](https://github.com/ahmtgrbz/Survey-Chain/blob/main/design/Mobile%20Application%20User-Interface.PNG)

# Requirements

* Python
* Flutter
* Infura
* MetaMask
