import Foundation
import CryptoKit

class SmartContract {
    var tokenRegistry: [String: Double]

    init() {
        tokenRegistry = [:]
    }

    func executeTransaction(transaction: Transaction) {
        if transaction.amount > 0 {

            if let senderBalance = tokenRegistry[transaction.sender], senderBalance >= transaction.tokensTransferred {
                tokenRegistry[transaction.sender] = senderBalance - transaction.tokensTransferred
                tokenRegistry[transaction.recipient, default: 0] += transaction.tokensTransferred
                print("Smart Contract: Tokens transferred successfully.")
            } else {
                print("Smart Contract: Insufficient balance for token transfer.")
            }
        } else {
            print("Smart Contract: Invalid transaction amount.")
        }
    }

    func checkBalance(address: String) -> Double {
        return tokenRegistry[address] ?? 0.0
    }
}
