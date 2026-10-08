# Configuration

> **⚠️ Reminder:** this module is **unsupported** and its security coverage is
> **revoked**. Treat everything below as configuration for an evaluation or a
> deployment you have taken responsibility for securing yourself.

Commerce Payment Elavon is configured on the payment‑gateway form — there is no
separate settings page.

## Add the gateway

1. Log in as a user who can administer Commerce.
2. Go to **Administration → Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
3. Choose the **Elavon** plugin. Elavon supports both an on‑site option (card
   fields on your checkout, with sale/authorise/capture/refund) and an off‑site
   redirect option for card payments where the card number never reaches your
   server — pick the one that suits your store.
4. Enter your **Elavon merchant credentials** (the merchant/API values from your
   Converge / Virtual Merchant account).
5. Set the **mode** — test vs live — and confirm it deliberately before going
   live.
6. Save.

## Handle credentials as secrets

Your Elavon merchant/API credentials are secrets. Do not commit them to exported
configuration. Store them in an environment variable and reference them through a
**Key** entity (or from `settings.php`) instead:

```bash
ddev dotenv set .ddev/.env --elavon-api-key=<value>
ddev restart
```

Always operate over **HTTPS**, and use separate test and live credentials for
your development and production environments.

## Validate payments server‑side

Ensure the gateway confirms or captures the charge against Elavon's authenticated
API and validates the payment result **server‑side**, rather than trusting a
client‑side result. Given the module's unsupported status, review this behaviour
in the code for the version you install before relying on it for real money, and
run a test‑mode transaction end to end first.
