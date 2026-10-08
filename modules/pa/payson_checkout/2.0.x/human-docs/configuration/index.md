# Configuration

Payson Checkout is configured as a **Commerce payment gateway**, not through a
standalone settings page.

## Add the Payson gateway

1. Log in as a user who can administer Commerce payment gateways.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway** and choose **Payson Checkout** as the plugin.

## The fields

- **Payson API / agent credentials** — the merchant credentials (agent ID and API
  key) from your Payson merchant account, used to authenticate the server-to-server
  API calls.
- **Mode** — **Test** or **Live** (the module supports Payson's test flow). Use
  Test while you verify the integration.
- The usual Commerce gateway options (display name, payment method types, and so
  on).

## Keep API credentials secret

Your Payson API key is live credential material. Store it in an environment
variable rather than committing it — for example with DDEV:

```bash
ddev dotenv set .ddev/.env --payson-api-key=<value>
ddev restart
```

(Keep `.ddev/.env` out of version control.) All traffic to Payson goes over
HTTPS. Review your configuration export before committing to make sure a real API
key is not written into the exported gateway config.

## How payment confirmation behaves

The gateway creates the checkout through Payson's API and reads the payment state
back from the **API's status response** — not from anything in the shopper's
return request. Because the authoritative status always comes from Payson
server-to-server, a forged or tampered return cannot make an order look paid. As
with any gateway, run a full test purchase against Payson's test environment and
confirm the return/confirmation flow marks the order correctly for your Commerce
version before going live.

## Save and test

Save the gateway, run a test purchase end to end, and confirm the order state
updates as expected. Switch to **Live** only once the test flow works.
