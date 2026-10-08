# Configuration

You configure PhonePe Payment the same way as any Drupal Commerce payment gateway:
by adding a gateway and entering your PhonePe merchant credentials.

## Add the payment gateway

1. Log in as a user who can administer Commerce.
2. Go to **Commerce → Configuration → Payment gateways → Add payment gateway**
   (`/admin/commerce/config/payment-gateways/add`).
3. Choose the **PhonePe** plugin and give the gateway a name.

## The fields

- **Merchant ID** — your PhonePe merchant identifier, from the PhonePe merchant
  dashboard.
- **Salt key** — the secret key PhonePe issues you, used to build and check request
  checksums. Treat this as a **secret**.
- **Salt index** — the index number that goes with your salt key.
- **Mode** — whether to run against PhonePe's UAT/test environment or production.
  Test end‑to‑end in UAT first; PhonePe documents its UAT testing at
  <https://developer.phonepe.com/v1/docs/uat-testing>.
- **Profile type** — the machine name of the profile type used for the customer's
  API details (default `customer`). It must include an address field, and you must
  add a mobile field with the machine name `field_mobile` to it (see
  [Installation](../installation/index.md)).

Save the gateway when the fields are complete.

## Keep the salt key out of version control

The salt key is a credential and should not be committed to your repository in
exported configuration. Store it in an environment variable and reference it at
runtime rather than hard‑coding it.

With DDEV, save the value into the project's dotenv file and restart so the
container picks it up:

```bash
ddev dotenv set .ddev/.env --phonepe-salt-key=<your-salt-key>
ddev restart
```

Then reference the variable from your settings (for example a configuration
override in `settings.php` using `getenv('PHONEPE_SALT_KEY')`) so the live key stays
in the environment. Never commit `.ddev/.env` or the raw key.

## Payment callback

PhonePe reports the payment result to `/phonepay_payment/callback/{order_id}` on
your site.
