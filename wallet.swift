import CryptoKit

struct Wallet {
    let publicKey: P256.Signing.PublicKey
    let privateKey: P256.Signing.PrivateKey

    init() {
        let keyPair = P256.Signing.KeyAgreement.PrivateKey()
        self.privateKey = keyPair
        self.publicKey = keyPair.publicKey
    }
}
