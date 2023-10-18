import Foundation

class Blockchain {
    private var nodes: [Node]
    private var pendingTransactions: [Transaction]
    private var tokenRegistry: [String: Double]
    private var smartContract: SmartContract

    init() {
        nodes = []
        pendingTransactions = []
        tokenRegistry = [:]
        smartContract = SmartContract()
    }

    func createNode(name: String) {
        nodes.append(Node(name: name))
    }

    func createGenesisBlock() -> Block {
        return Block(index: 0, previousHash: "0", transactions: [], nonce: 0)
    }

    func addBlock(transactions: [Transaction], toNodeWithName nodeName: String) {
        let node = nodes.first { $0.name == nodeName }
        let previousBlock = node?.blockchain.last ?? createGenesisBlock()
        let newBlock = mineBlock(index: node?.blockchain.count ?? 0, previousHash: previousBlock.hash, transactions: transactions)
        node?.blockchain.append(newBlock)
    }

    func createTransaction(sender: String, recipient: String, amount: Double, tokensTransferred: Double) {
        let transaction = Transaction(sender: sender, recipient: recipient, amount: amount, tokensTransferred: tokensTransferred, privateKey: P256.Signing.PrivateKey())
        pendingTransactions.append(transaction)
    }

    func mineBlock(index: Int, previousHash: String, transactions: [Transaction]) -> Block {
        var nonce = 0
        var hash = ""
        while !hash.hasPrefix("0000") {
            nonce += 1
            hash = Block(index: index, previousHash: previousHash, transactions: transactions, nonce: nonce).hash
        }
        print("Block mined with nonce: \(nonce)")
        return Block(index: index, previousHash: previousHash, transactions: transactions, nonce: nonce)
    }

    func printBlockchain(nodeName: String) {
        if let node = nodes.first(where: { $0.name == nodeName }) {
            print("Blockchain for Node \(node.name):")
            for block in node.blockchain {
                print("Block \(block.index):")
                print("Timestamp: \(block.timestamp)")
                print("Transactions:")
                for transaction in block.transactions {
                    print("- From: \(transaction.sender)")
                    print("  To: \(transaction.recipient)")
                    print("  Amount: \(transaction.amount)")
                }
                print("Hash: \(block.hash)")
                print("Previous Hash: \(block.previousHash)")
                print("--------------")
            }
        }
    }
}
