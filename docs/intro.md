---
sidebar_position: 1
---

# General project overview

---

### Why do we bet on self-sovereign identity

The self-sovereign identity (SSI) concept appears to be one of the most prominent identity technologies. The main goal of SSI is to shift the locus of control over users' data and authorization function. It gives back the power of profile control to people while preserving a prominent level of privacy and security. The trust triangle, which is the core of the SSI ecosystem, presumes that the User owns his decentralized identifier (DID) and holds privately his own verifiable credentials (VCs) issued by authorized actors (Issuers). These credentials are accepted and verified by Verifiers which check up the Issuers signature and decentralized identifier of the User.

Various consortiums and state authorities have paid attention to the SSI development and have already undertaken certain actions to set up proper agenda and to hold the best positions at the frontier of the technology.

Being technology-agnostic the SSI, however, perfectly fits any blockchain ecosystem due to its decentralized and trustless character. Blockchain networks can perform the role of decentralized virtual machines for SSI-based smart contracts or even store the data of certain SSI components.

### What is FreeTON.id

[FreeTON.](https://FreeTON.ID)id is a demo application that demonstrates the results of our efforts to implement [decentralized identifiers](https://www.w3.org/TR/did-core/) within the Free TON network.

A decentralized identifier is one of the basic components for each and every SSI use case. That's why blockchain network integration into the Self-sovereign Identity industry should be started precisely with DID method implementation.

[FreeTON.id](https://FreeTON.id) was created with the purpose of participation in the [#39 Contest proposal: FreeTON Self-Sovereign Identity Framework (Stage 2)](https://defi.gov.freeton.org/proposal?proposalAddress=0%3A91c364d4312bbb621ff199ba08e42f3a99b919b14ca29104655bf1835b48781b). We attempted to create a demo that will contain a functional DID component. Therefore, we imitated the work of discounting and bonus platform which employs DIDs for authorization purposes.

The scope of the solution and our deliverables are contained in the "**Our project scope"** section.

### Our project scope

Our primary objective was to create **DID method specification** and **its implementation** within the FreeTON network, as well as **a prototype of a real use case** engaging DID creation and utilization.

What we have done:

- Prepared the Free TON **DID method specification** that defines the aspects of TON DID creation and management (see **Technical Overview** section)
- Developed **[DID Registry](https://ton.live/accounts/accountDetails?id=0%3Ac03aa62b5d2151eba54bd794e8029df1e933158a79331393895b274760f8ccbb)** smart contract on the FreeTON network for managing DIDs and DID Documents. The source code can be found [here](https://gitlab.com/freeton-id/did-storage-contract).
- Developed corresponding **SDK** for DID Regsitry. Prepared SDK documentation.
- Developed **[FreeTON.id](https://freeton.id) web application** that demonstrates the flow of DID creation and authorization with DID.

**NB:** *The user flow after the authorization stage is definitely out of the scope and used to demonstrate the level of user experience and authorization capabilities in the developed SSI ecosystem. This part gives us directions for further development and contribution to the Free TON ecosystem. **Basically, there is only one true VC: Proof of Free TON address. The rest of the VCs are mocked up and present only for demonstration purposes.***

### Further development

At the moment, we can highlight the following potential directions:

1. Tiered trust architecture proposal that includes identity level as SSI and addresses a wider range of trust relationships and business modeles.
2. Trust framework for Everscale, a realization of DLT-based trust.
   1. Decentralized identifiers framework according to W3C recommendation [Decentralized Identifiers (DIDs) v1.0](https://w3c.github.io/did-core/).
   2. Verifiable Credentials framworwk according to W3C recommendation [Verifiable Credentials Data Model v1.1](https://www.w3.org/TR/vc-data-model/)
4. Integrations with VC providers and services accepting VCs.
5. Development of verifiable presentation user flow.

## Showcase

In our showcase, we have fully implemented the process of DID creation and authorization with the help of it. Further, the User is able to receive various VCs from the list in advance or obtain them by choosing Free TON ecosystem services.

[![SHOWCASE](https://i.imgur.com/ArElcmJ.png)](https://youtu.be/cxPzmXy-uyw)
https://youtu.be/cxPzmXy-uyw

The following product scenarios are fictional. We do not imply that the mentioned services (Pokerton; Ton Swap; EasyVote) use our credential scheme and provide indicated bonuses and discounts.

---

## Technical Overview

### General architecture

Our solution has a multi-component architecture divided into frontend and backend parts. Both frontend and backend keep communicating with the DID Storage contract for performing chain transactions.

![Untitled](/img/docs/Untitled.png)

The process of components interaction for DID authorization (our primary use case) is detailed on the sequence diagram in **DID Authentication for [FreeTON.id](https://FreeTON.id)** section.

### **Our stack**

**Backend**

- Node.JS + TypeSctipt
- GraphQL API (+ GraphQL-codegen for TS types generation)
- Prisma as ORM

**Frontend**

- React as JS framework
- Crystal Wallet for signing data and performing chain transactions

**Smart contract**:

- Solidity language for smart contracts

**Utils**:

- ESLint for code analysis

### DID Authentication for FreeTON.id

For greater clarity, we have prepared a sequence diagram for the process of user authentication with DID from the very beginning (DID creation with Crystal wallet). The diagram explains how all the core components (frontend app, Crystal wallet, DID Storage contract, and backend app) interact with each other.

![Untitled](/img/docs/Untitled_1.png)

### FreeTON.id DID Specification

We have prepared a Free TON DID specification, which defines how DID method for the Free TON network is implemented.

[Free TON DID Specification](/docs/Additional%20documents/Free%20TON%20DID%20Specification)

### DID SDK Documentation

We have developed a TypeScript SDK for simpler implementations engaging DID Storge smart contract.

[DID SDK Documentation](/docs/Additional%20documents/DID%20SDK%20Documentation)

### API Documentation

[FreeTON.id](https://FreeTON.id) GraphQL API documentation can be found on the following page: [docs-api.freeton.id](https://docs-api.freeton.id/)

---

## How to build up and use FreeTON.id

### Frontend application

A [React](https://reactjs.org/)-based web application serves as DID former and transactions signer. Source code, as well as detailed deployment instructions, may be found in [this repository](https://gitlab.com/freeton-id/did-showcase).

**How to build and run:**

1. **Clone the source repository to your machine:**
   - `git clone ... && cd did-showcase`
2. **Download and install dependencies:**
   - `npm install`
3. **Setup environment (clone and edit .env file):**
   - `cp .env.example .env`
4. **Generate Typescript types and GraphQL client hooks based on GraphQL schema and queries:**
   - `npm run gen`
5. **Launch the app:**
   - `npm run start (development launch) / npm run serve (production launch)`

### Backend application

[FreeTON.id](https://FreeTON.id) backend is a lightweight server app built with [Node.js](https://nodejs.org/en/). Source code with deployment instructions may be found in [this repository](https://gitlab.com/freeton-id/backend).

**How to build and run:**

1. **Clone the source repository to your machine:**
   - `git clone ... && cd backend/`
2. **Download and install dependencies:**
   - `npm install`
3. **Prepare configuration file (copy template and edit):**
   - `cp src/config/config_example.ts src/config/config.ts`
4. **Generate types:**
   - `npm run gen`
5. **Launch the app:**
   - `npm run dev (development run) / npm start (production run)`

### First launch instructions (if you don't have Crystal Wallet still)

- Go to the [freeton.id](https://freeton.id) site.
- Click "Go to Chrome Web Store" and install the [Crystal Wallet](https://chrome.google.com/webstore/detail/ton-crystal-wallet/cgeeodpfagjceefieflmdfphplkenlfk) extension there. Ensure you have **0.2.15 version** of the wallet at least.

![Untitled](/img/docs/Untitled_2.png)

![Untitled](/img/docs/Untitled_3.png)

- Follow the instructions on the Crystal Wallet setup page. Create a wallet.

![Untitled](/img/docs/Untitled_4.png)

- Connect [FreeTON.id](https://FreeTON.id) to your wallet

![Untitled](/img/docs/Untitled_5.png)

![Untitled](/img/docs/Untitled_6.png)

- Top up your wallet balance
- Deploy your wallet to the network (**IMPORTANT!**)

![Untitled](/img/docs/Untitled_7.png)

- Go back to the site and enjoy the service.

![Untitled](/img/docs/Untitled_8.png)

---

## License (MIT)

Copyright (c) [FreeTON.](https://FreeTON.ID)id team

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
