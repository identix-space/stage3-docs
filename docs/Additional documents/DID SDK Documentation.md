# DID SDK

## Client SDK

### Installation

- Clone the files from [DIDStorageSDK](https://gitlab.com/freeton-id/did-showcase/-/tree/master/src/utils/DIDStorageSDK) package.
- Use DIDStorage class methods (see [index.ts](https://gitlab.com/freeton-id/did-showcase/-/blob/master/src/utils/DIDStorageSDK/index.ts)). Ensure all the dependencies are satisfied.

### Initialize SDK

```tsx
import {didStorage} from '<PATH_TO_"routing"_PACKAGE>'
```

### Create DID

```tsx
const resCreatedDid = await didStorage.createDID();
```

Params:

- **dryRun** (Boolean, default value: **false):** use **true** for test purposes if you don't want to write transaction in the blockchain.

Output type: **DIDDocument**

### Get DID Document by DID

```tsx
const resDidDoument = didStorage.loadDIDDocument(DID_STR);
```

Params:

- **DID** (String): DID value without "***did:freeton***:" prefix.

Output type: **DIDDocument** (nullable)

### Sign data

```tsx
const singedData = await didStorage.signData(data)
```

Params:

- **Data** (String): the data to be signed

Output type: **[ton-inpage-provider](https://github.com/broxus/ton-inpage-provider).RawProviderApiResponse<''signData''>**

### Verify signature

```ts
const result = await verifySignature(data, signature)
```

Params:

- **Data** (String): data that should be checked
- **Signature** (String): signature

Output type: **Boolean**

---

## Issuer/Verifier SDK

### Installation

- Use [DIDTools](https://gitlab.com/freeton-id/backend/-/blob/master/src/tools/DIDTools.ts) class methods. Ensure all the dependencies are satisfied.

### Init SDK

```tsx
import {DIDTools} from '<PATH_TO_tools/DIDTools>';
```

### Load DID Document by DID

```tsx
const DIDDoc = await DIDTools.loadDIDDocument(did);
```

Params:

- **DID** (String): DID value ****without "***did:freeton***:" prefix.

Output type: **DIDDocument** (nullable)

### Get wallet custodians

```tsx
const custodians = await DIDTools.getMultiSigCustodians(walletAddress);
```

Params:

- **walletAddress** (string): the address of the checked wallet

Output type: **string[]** array of wallet custodians' addresses. Use to check whether the current DID owns the wallet address passed as the argument. 

### Sign message (Ed25519)

```tsx
const signature = await DIDTools.signMessage({
                message: MESSAGE_STRING,
                privateKey: KEY_STRING
            });
```

Params:

- **{message, privateKey}** structure: **message** (string),  **privateKey** (string). Message to be signed and the private key to sign.

Output type: **String**. Ed25519 signature.

### Verify message

```tsx
const valid = await DIDTools.verifyMessage({
                signatureHex: hex,
                message: message,
                publicKey: publicKey
            });
```

Params:

- **{signatureHex, message, publicKey}** structure: signatureHex (**string**), message (**string**), publicKey (**string**)

Output type: **Boolean.**
