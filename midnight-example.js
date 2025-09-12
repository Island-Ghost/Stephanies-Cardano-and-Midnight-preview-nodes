// Midnight Ledger Integration Example
// This demonstrates basic usage of the @midnight-ntwrk/ledger package

const { Ledger } = require('@midnight-ntwrk/ledger');

async function initializeMidnightLedger() {
    try {
        console.log('🌙 Initializing Midnight Ledger...');
        
        // Create a new ledger instance
        const ledger = new Ledger({
            network: 'testnet', // Use testnet for development
            endpoint: 'http://localhost:3001' // Connect to local Cardano node
        });

        console.log('✅ Midnight Ledger initialized successfully');
        
        // Example: Get ledger info
        const info = await ledger.getInfo();
        console.log('📊 Ledger Info:', info);
        
        return ledger;
        
    } catch (error) {
        console.error('❌ Failed to initialize Midnight Ledger:', error.message);
        throw error;
    }
}

// Example usage
async function main() {
    try {
        const ledger = await initializeMidnightLedger();
        
        // Add more Midnight operations here
        console.log('🚀 Ready to interact with Midnight network');
        
    } catch (error) {
        console.error('💥 Error:', error.message);
        process.exit(1);
    }
}

// Run if this file is executed directly
if (require.main === module) {
    main();
}

module.exports = { initializeMidnightLedger };
