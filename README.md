# 🪙 Wallet API Documentation

## 1. 🔥Problem

Managing transactions between users, teams, and stocks requires a structured internal wallet system. Each entity should have its own wallet, capable of sending, receiving, and tracking balances securely.

## 2. 🚒 Solution

This API provides an internal wallet system where users, teams, and stocks have their own wallets. Transactions (STI for deposits, withdrawals, and transfers) are securely recorded in a relational database with JWT-based authentication.

## 3. 🧯 Feature Description

- **Wallet System**: Each entity (User, Team, Stock) has a wallet.
- **Transaction Types**:
  - **Deposit**: Money is credited to a wallet.
  - **Withdraw**: Money is debited from a wallet.
  - **Transfer**: Money is transferred between wallets.
- **Authentication**: JWT-based authentication to secure API endpoints.
- **Balance Calculation**: Wallet balance is dynamically calculated from transaction records.

## 4. 🌄 Database Schema Design

### **Wallets Table**

| Column      | Type    | Description                                 |
| ----------- | ------- | ------------------------------------------- |
| id          | Integer | Primary key                                 |
| owner_id    | Integer | Polymorphic association (User, Team, Stock) |
| owner_type  | String  | Defines the entity type                     |
| balance     | Decimal | Wallet balance (default: 0.0)               |

### **Transactions Table**

| Column                    | Type    | Description                                                    |
| ------------------------- | ------- | -------------------------------------------------------------- |
| id                        | Integer | Primary key                                                    |
| wallet_id                 | Integer | Associated wallet ID                                           |
| amount                    | Decimal | Transaction amount                                             |
| type                      | String  | Type: CreditTransaction, DebitTransaction, TransferTransaction |
| source_wallet_id          | Integer | Source wallet (for transfers)                                  |
| target_wallet_id          | Integer | Target wallet (for transfers)                                  |
| transfer_transaction_id   | Integer | Reference to the parent TransferTransaction                    |

### **User Table**

| Column                    | Type    | Description                                                    |
| ------------------------- | ------- | -------------------------------------------------------------- |
| id                        | Integer | Primary key                                                    |
| name                      | Integer | User's name                                                    |
| email                     | Decimal | User's email                                                   |
| password_digest           | String  | Encrypted password                                             |

### **Team Table**

| Column                    | Type    | Description                                                    |
| ------------------------- | ------- | -------------------------------------------------------------- |
| id                        | Integer | Primary key                                                    |
| name                      | Integer | Team's name                                                    |

### **Stock Table**

| Column                    | Type    | Description                                                    |
| ------------------------- | ------- | -------------------------------------------------------------- |
| id                        | Integer | Primary key                                                    |
| symbol                    | Integer | Team's name                                                    |
| company_name              | Integer | Team's name                                                    |


## 5. 🔠 API Endpoints and Example Requests

### **Authentication**

#### **Login**

**Request:**

```sh
curl -X POST http://localhost:3000/auth/login \
     -H "Content-Type: application/json" \
     -d '{"email": "user@example.com", "password": "password"}'
```

**Response:**

```json
{
  "token": "YOUR_JWT_TOKEN"
}
```

### **Wallet Operations**

#### **Deposit Money**

**Request:**

```sh
curl -X POST http://localhost:3000/wallets/1/deposit \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer YOUR_JWT_TOKEN" \
     -d '{"amount": 100.0}'
```

#### **Withdraw Money**

**Request:**

```sh
curl -X POST http://localhost:3000/wallets/1/withdraw \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer YOUR_JWT_TOKEN" \
     -d '{"amount": 50.0}'
```

#### **Transfer Money**

**Request:**

```sh
curl -X POST http://localhost:3000/wallets/transfer \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer YOUR_JWT_TOKEN" \
     -d '{"source_wallet_id": 1, "target_wallet_id": 2, "amount": 30.0}'
```

#### **Get Wallet Balance**

**Request:**

```sh
curl -X GET http://localhost:3000/wallets/1/balance \
     -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

## 6. 👷 Getting Started

### **Setup the Project**

```sh
git clone https://github.com/your-repo/wallet-api.git
cd wallet-api
bundle install
rails db:create db:migrate
rails server
```

### **Run the API Server**

```sh
rails s
```

### **Create a User for Testing**

```sh
rails c
User.create!(name: "John Doe", email: "user1@example.com", password: "password")
User.create!(name: "Math Kuy", email: "user2@example.com", password: "password")
```


