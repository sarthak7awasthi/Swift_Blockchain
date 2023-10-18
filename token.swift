struct Token {
    let owner: String
    var balance: Double

    init(owner: String, balance: Double) {
        self.owner = owner
        self.balance = balance
    }

    func transfer(to recipient: String, amount: Double) -> Bool {
        if balance >= amount {
            balance -= amount
            // Transfer the tokens to the recipient (add code for this)
            return true
        } else {
            return false
        }
    }
}
