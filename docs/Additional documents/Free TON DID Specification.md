# Everscale DID Specification

## Key terms (according to [did-core](https://www.w3.org/TR/did-core))

**Decentralized identifiers (DIDs)** are globally unique persistent identifiers that do not require a centralized registration authority and are often generated and/or registered cryptographically.

**DID controller** of a DID is the entity (person, organization, or autonomous software) that has the capability to make changes to a [](https://www.w3.org/TR/did-core/#dfn-did-documents)DID Document. 

**DID document** is a document containing information associated with a DID. They typically express verification methods, such as cryptographic public keys, and services relevant to interactions with the DID subject.

**DID method** is the mechanism by which a particular type of [DID](https://www.w3.org/TR/did-core/#dfn-decentralized-identifiers) and its associated DID document is created, resolved, updated, and deactivated.

**DID subject** is the entity identified by a DID and described by a DID document.

**Verifiable data registry** is a system or network to which DIDs are recorded to be resolvable to DID Documents.

## Abstract

Decentralized identifiers are a new type of identifier that may be decoupled from any type of centralized registries and certificate authorities. DIDs designed in order to enable the proving of control without requiring permission from any third party with the help of cryptography. Each DID associates its subject with a DID Document which contains the data (verification methods, services, etc.) that enables trustable interactions with this subject.

**Everscale.id** employs a DID method that is implemented natively on **Everscale network**. It uses the Everscale smart contracts to store information that makes up the DID document for the Everscale.id.

The name string that shall identify this DID method is **"everscale".**

## DID Syntax

The generic DID scheme is a URI scheme conformant with RFC3986.

According to the W3C's Decentralized Identifiers (DIDs) v1.0 data model, a Decentralized Identifier is a URI composed of three parts: the scheme (**did:**), the method identifier (**everscale**), and a unique, method-specific identifier specified by the DID method

Everscale DID method corresponds to requirements laid down in [section 8.1](https://www.w3.org/TR/did-core/#method-syntax) of did-core.

A DID that uses this method MUST begin with the following prefix: **did:everscale**. Per the DID specification, this string MUST be in lowercase. The remainder of the DID, after the prefix, is a **method-specific identifier,** which is an Everscale contract address, 64-digit hexadecimal number in lowecase.

*Caveat: currently, this implmentation don't support workchain id as a part of DID. This feature will be added in future.*

```html
did:everscale:<method-specific-identifier>
```
Example
```html
did:everscale:dddd2b73f27df636f72fec7c124b97247bde9d88d7e2f722407d2fa35b0e05e9
```

### Generic relations scheme

![Untitled](/img/docs/Free_TON_DID_Specification/Untitled.png)

## CRUD Operation Definitions

The DID Registry smart contract serves as a primary interface through all the DID management operations are performed. Therefore, all the CRUD operations should be done with corresponding contract methods calls either directly or via our DID Registry SDK.

### Create

Everscale DID can be constructed via trivial string operation and does not need any dedicated API, once user knows an Everscale blockchain address.

An Everscale DID Document is created by deploying DID Documetn Contract to Everscale blockchain and calling contract methods for DID meta document creation. The meta document takes a ton wallet address as the controller. The controller is the DID which is allowed to update the DID Document info.

To created DID, the **issueDidDocument** method in DID Registry with suitable arguments should be called. Note that `docOwnerPubKey` and `docOwnerAddress` are mutually exclusive: either internally (Everscale address) or externally (public key) owned documents are allowed.

```graphql
name: 'issueDidDocument',
        inputs: [
            {name: 'docOwnerPubKey', type: 'uint256'},
            {name: 'docOwnerAddress', type: 'address'},
            {name: 'content', type: 'string'},
            {name: 'initialDocBalance', type: 'uint32'}
        ],
        outputs: [
            {name: 'didDocAddr', type: 'uint256'}
        ]
```

The result of the transaction is a DID record in the DID Registry:

```json
{
  "id": 74,
  "doc_hash": "f34a776c1e77f8d046cc02be9a15d419b829f0cbb20c23a274012e7f86ea0324",
  "issuer": "0:d0936a9fc29b5175487208b1d07ab8042ce7ddbc2de7e271c4087ca833b865cc",
  "data": {
    "isActive": "true",
    "ownerPubKey": "0",
    "ownerAddress": "0:ff09aa36a9fc29b0000482208b1d07ab8042ce7ddbc2de7e1c4087ca833b865cc",
    "issuingAuthority":"0:d0936a9fc29b5175487208b1d07ab8042ce7ddbc2de7e271c4087ca833b865cc",
    "representations": {"1": "content!"}
  }
}
```

The `content` param is an arbitrary string, which is not intepreted by the smart contracts, but it may as well carry e.g. a JSON-LD  content.

```json
{
  "id": "978cae5ccb0048de4bf6c76ffba5c2686987fd72494137de8373a84e5f720063",
  "createdAt": "1633219196333",
  "@context": [
      "https://www.w3.org/ns/did/v1",
      "https://w3id.org/security/suites/ed25519-2020/v1"
  ],
  "publicKey": "978cae5ccb0048de4bf6c76ffba5c2686987fd72494137de8373a84e5f720063"
}
```

### Read

Currently, any user can get a list of DID Documents, a DID Registry ever issued for a particular owner. Note that `eitherDocOwnerPubKey` and `orDocOwnerAddress` are mutually exclusive: either internally (Everscale address) or externally (public key) owned documents are allowed.

```graphql
{
    name: 'getDidDocs',
    inputs: [
        {name: 'eitherDocOwnerPubKey', type: 'uint256'},
        {name: 'orDocOwnerAddress', type: 'address'}
    ],
    outputs: [
        {name: 'docs', type: 'address[]'}
    ]
}
```
DID Document's content can be acquired via the `DidDocument`'s getter
```graphql
{
    name: 'getContent',
    inputs: [
        {name: 'representationType', type: 'uint8'}
    ],
    outputs: []
}
```
The `representationType` param is currently ignored and designed to comply W3C DID specification in the future.

### Update and Deactivate

DID Document's content can be set via the `DidDocument`'s setter
```graphql
{
    name: 'setContent',
    inputs: [
        {name: 'content', type: 'string'},
        {name: 'representationType', type: 'uint8'}
    ],
    outputs: []
}
```
The `representationType` param is currently ignored and designed to comply W3C DID specification in the future.

An owner can also mark DID Document as inactive (and make it active again), and any user can check the status of DID document via special setter and getter

```graphql
{
    name: 'getActive',
    inputs: [],
    outputs: [ {name:'value0', type:'bool'}]
}
```

```graphql
{
    name: 'setActive',
    inputs: [
        {name: 'newValue', type: 'bool'}
    ],
    outputs: []
}
```

## Security Requirements

Everscale ID derives most of its security properties from the Everscale blockchain. Most notably censorship resistance, decentralization, and requiring a minimal amount of data to be synced to completely verify the integrity of a Everscale ID. We also took into consideration the requirements laid down in [Section 8.3](https://www.w3.org/TR/did-core/#security-requirements) of did-core. 

## Privacy Requirements

See [§ 10. Privacy Considerations](https://www.w3.org/TR/did-core/#privacy-considerations) in did-core.

## Extensibility

The Everscale ID Method could also easily be extended to support other features specified in [did-core](https://w3c.github.io/did-core/) (e.g endpoints, verification methods, etc.)
