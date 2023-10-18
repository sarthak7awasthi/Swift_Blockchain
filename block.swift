import Foundation
import CryptoKit

struct Block {
    let index: Int
    let previousHash: String
    let timestamp: Date
    let transactions: [Transaction]
    let hash: String
    let nonce: Int

    init(index: Int, previousHash: String, transactions: [Transaction], nonce: Int) {
        self.index = index
        self.previousHash = previousHash
        self.timestamp = Date()
        self.transactions = transactions
        self.nonce = nonce
        self.hash = calculateHash()
    }

    func calculateHash() -> String {
        let transactionStrings = transactions.map { "\($0.sender) -> \($0.recipient): \(String(format: "%.2f", $0.amount)), Tokens: \(String(format: "%.2f", $0.tokensTransferred))" }
        let data = "\(index)\(previousHash)\(timestamp)\(transactionStrings.joined())\(nonce)"
        return SHA256.hash(data: data).compactMap { String(format: "%02x", $0) }.joined()
    }
}
