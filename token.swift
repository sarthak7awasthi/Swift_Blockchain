struct Token {
    let owner: String
    var balance: Double

    init(owner: String, balance: Double) {
        self.owner = owner
        self.balance = balance
    }

    func transfer(to recipient: String, amount: Double, tokenRegistry: inout [String: Double]) -> Bool {
        if balance >= amount {
            balance -= amount
            tokenRegistry[recipient, default: 0] += amount
            return true
        } else {
            return false
        }
    }
}
