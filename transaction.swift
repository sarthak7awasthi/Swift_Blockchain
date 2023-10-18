import Foundation
import CryptoKit

struct Transaction {
    let sender: String
    let recipient: String
    let amount: Double
    let tokensTransferred: Double
    let signature: String

    init(sender: String, recipient: String, amount: Double, tokensTransferred: Double, privateKey: P256.Signing.PrivateKey) {
        self.sender = sender
        self.recipient = recipient
        self.amount = amount
        self.tokensTransferred = tokensTransferred
        self.signature = Transaction.sign(sender: sender, recipient: recipient, amount: amount, tokensTransferred: tokensTransferred, privateKey: privateKey)
    }

    static func sign(sender: String, recipient: String, amount: Double, tokensTransferred: Double, privateKey: P256.Signing.PrivateKey) -> String {
        let message = "\(sender)->\(recipient):\(amount), Tokens: \(tokensTransferred)"
        let signature = try! P256.Signing.ECDSASignature(data: privateKey.sign(message.data(using: .utf8)!))
        return signature.compactRepresentation.base64EncodedString()
    }

    func verifySignature(publicKey: P256.Signing.PublicKey) -> Bool {
        let message = "\(sender)->\(recipient):\(amount), Tokens: \(tokensTransferred)"
        guard let signatureData = Data(base64Encoded: signature) else {
            return false
        }
        do {
            let signature = try P256.Signing.ECDSASignature(compactRepresentation: signatureData)
            return publicKey.isValidSignature(signature, for: message.data(using: .utf8)!)
        } catch {
            return false
        }
    }
}
