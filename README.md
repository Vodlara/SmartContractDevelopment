
A secure token locking system with reward calculation on BNB Smart Chain (BSC).

![Project Preview](https://via.placeholder.com/800x400.png?text=Safe+Vault+Interface) *Add screenshot here*

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Deployment](#deployment)
- [Usage](#usage)
- [Testing](#testing)
- [Troubleshooting](#troubleshooting)
- [License](#license)

## Overview
**Smart Contract**:  
🔒 Secure vault system allowing users to:  
- Lock tokens for specified periods  
- Earn calculated rewards  
- Maintain individual compartments  

**Frontend**:  
🖥️ Web interface for:  
- Wallet connection (MetaMask)  
- Token locking management  
- Real-time vault status tracking  

## Features
### Smart Contract
- Token time-locking mechanism
- Time-based reward calculation
- Individual user compartments
- Owner-controlled reward rates
- Secure access controls

### Frontend
- MetaMask integration
- Token locking interface
- Real-time status updates
- Network validation (BNB Chain)
- Transaction monitoring

## Prerequisites
- Node.js v16+ & npm
- MetaMask (configured for BSC)
- BNB tokens ([Testnet Faucet](https://testnet.bnbchain.org/faucet-smart))
- Truffle/Hardhat (for deployment)
- Solidity compiler ^0.8.0

## Installation
```bash
# Clone repository
git clone https://github.com/your-username/safe-vault.git
cd safe-vault

# Install contract dependencies
cd contract
npm install

# Install frontend dependencies
cd ../frontend
npm install

Configuration
Smart Contract
Create .env in /contract:
MNEMONIC="your wallet seed phrase"
BSCSCAN_API_KEY="your api key"
BSC_TESTNET_URL="https://data-seed-prebsc-1-s1.bnbchain.org:8545"

Frontend
Create .env in /frontend:

REACT_APP_CONTRACT_ADDRESS="0x..."
REACT_APP_BSC_CHAIN_ID=56
REACT_APP_RPC_URL="https://bsc-dataseed.bnbchain.org"

Deployment
Compile contract:

bash
cd contract
truffle compile
Deploy to BSC Testnet:

bash
truffle migrate --network bsc_testnet
Start frontend:

bash
cd ../frontend
npm start

Usage
Connect Wallet
Click "Connect Wallet" and approve connection in MetaMask

Lock Tokens
Lock Interface

Enter amount (BNB)

Set duration (days)

Confirm transaction

View Vault
Monitor locked assets and rewards:

Current locked amount

Accrued rewards

Unlock timestamp

Testing
Run smart contract tests:
cd contract
truffle test

Sample test output:

Copy
  Contract: SafeVault
    ✓ should deploy with initial settings
    ✓ should lock tokens (1200ms)
    ✓ should prevent early withdrawal
    ✓ should calculate rewards
    ✓ should update reward rate (owner only)
  5 passing (3s)

roubleshooting
Issue	Solution
MetaMask not detected	Refresh page & check extension permissions
Wrong network	Configure BSC in MetaMask
Transaction stuck	Increase gas limit (150000+ recommended)
Contract errors	Verify ABI matches deployed contract
License
MIT License - See LICENSE for details
