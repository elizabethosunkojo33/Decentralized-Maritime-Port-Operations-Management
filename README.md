# Decentralized Maritime Port Operations Management

A comprehensive blockchain-based system for managing maritime port operations using Clarity smart contracts on the Stacks blockchain.

## Overview

This system provides a decentralized solution for managing various aspects of maritime port operations, including port authority verification, vessel scheduling, cargo handling, customs coordination, and performance optimization.

## Features

### 🏛️ Port Authority Verification
- Register and verify port authorities
- Manage authority credentials and details
- Revoke authority status when needed

### 🚢 Vessel Scheduling
- Schedule vessel arrivals and departures
- Update vessel status in real-time
- Track vessel operations across multiple ports

### 📦 Cargo Handling
- Create and manage cargo operations
- Track cargo types and quantities
- Monitor handling status and completion

### 🛃 Customs Coordination
- Initiate customs clearance processes
- Approve or reject clearances
- Maintain clearance records and notes

### 📊 Performance Optimization
- Record port performance metrics
- Calculate efficiency scores
- Track and compare port performance

## Smart Contracts

### Port Authority Contract (\`port-authority.clar\`)
Manages the registration and verification of port authorities.

**Key Functions:**
- \`register-port-authority\`: Register a new port authority
- \`is-port-authority\`: Verify if a principal is a registered authority
- \`get-authority-details\`: Retrieve authority information
- \`revoke-authority\`: Remove authority status

### Vessel Scheduling Contract (\`vessel-scheduling.clar\`)
Handles vessel arrival and departure scheduling.

**Key Functions:**
- \`schedule-vessel\`: Create a new vessel schedule
- \`update-vessel-status\`: Update vessel operational status
- \`get-vessel-schedule\`: Retrieve schedule information

### Cargo Handling Contract (\`cargo-handling.clar\`)
Manages cargo operations and tracking.

**Key Functions:**
- \`create-cargo-operation\`: Initialize cargo handling
- \`complete-cargo-operation\`: Mark operation as completed
- \`get-cargo-operation\`: Retrieve operation details

### Customs Coordination Contract (\`customs-coordination.clar\`)
Coordinates customs clearance processes.

**Key Functions:**
- \`initiate-clearance\`: Start customs clearance
- \`approve-clearance\`: Approve customs clearance
- \`reject-clearance\`: Reject clearance with reason

### Performance Optimization Contract (\`performance-optimization.clar\`)
Tracks and optimizes port performance metrics.

**Key Functions:**
- \`record-metrics\`: Record performance data
- \`get-metrics\`: Retrieve performance metrics
- \`get-port-efficiency\`: Get efficiency ranking

## Installation

1. Clone the repository
2. Install dependencies: \`npm install\`
3. Deploy contracts to Stacks blockchain
4. Configure contract addresses in your application

## Testing

Run the test suite using Vitest:

\`\`\`bash
npm test
\`\`\`

Tests cover all major contract functions and error conditions.

## Usage Example

\`\`\`clarity
;; Register a port authority
(contract-call? .port-authority register-port-authority
'ST2CY5V39NHDPWSXMW9QDT3HC3GD6Q6XX4CFRK9AG
"Port of Miami"
"Miami, FL")

;; Schedule a vessel
(contract-call? .vessel-scheduling schedule-vessel
"SHIP001"
u1000
u2000)

;; Create cargo operation
(contract-call? .cargo-handling create-cargo-operation
u1
"containers"
u100)
\`\`\`

## Error Codes

- **100-102**: Port Authority errors
- **200-202**: Vessel Scheduling errors
- **300-302**: Cargo Handling errors
- **400-402**: Customs Coordination errors
- **500-502**: Performance Optimization errors

## Security Considerations

- Only registered port authorities can perform certain operations
- Contract ownership is restricted to deployment address
- All operations are logged on-chain for transparency
- Input validation prevents invalid data entry

## Contributing

1. Fork the repository
2. Create a feature branch
3. Add tests for new functionality
4. Submit a pull request

## License

MIT License - see LICENSE file for details.

## Support

For questions or support, please open an issue in the repository.
