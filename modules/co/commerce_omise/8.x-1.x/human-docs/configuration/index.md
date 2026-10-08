# Configuration

Commerce Omise is configured as a **Commerce payment gateway**. There is no separate
global settings page.

## Store your API credentials securely

Your Omise API keys are secrets — never hard‑code or commit them. With DDEV, keep
each value in an environment variable and load it through a Key entity:

```bash
ddev dotenv set .ddev/.env --omise-secret-key=<value>
ddev restart
```

Install the Key module if it isn't enabled, then reference the variable from a Key
entity so the secret never lives in exported configuration.

## Add the Omise payment gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Choose the **Omise** plugin.
3. Enter your Omise API credentials (reference the Key entities above) and choose
   **Test** or **Live** mode.
4. Save. Only trusted roles should be able to administer payment gateways.

## Test first

Run in **Test** mode and confirm that a successful checkout corresponds to an Omise
charge before switching to live.
