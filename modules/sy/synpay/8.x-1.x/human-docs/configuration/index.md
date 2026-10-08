# Configuration

synpay is configured on its settings form at the `synpay.settings` route. This is
where you choose which payment gateways to accept and enter each gateway's merchant
credentials. Because this module moves money, read the security section below before
going live.

## Open the settings form

1. Log in as a user with permission to administer the site's configuration (an
   administrator by default). synpay also provides its own permissions — grant them
   only to trusted roles.
2. Go to the synpay settings form (the `synpay.settings` configuration route).

## Configure your gateway

For each gateway you want to accept:

- **Enable the provider** for the gateway you use (for example YooKassa, Robokassa,
  CloudPayments, PayKeeper, Sber, Tinkoff or Alfa).
- **Enter the merchant credentials** the gateway gave you — typically a merchant/shop
  identifier plus a secret key. Enter the exact values from your gateway's merchant
  dashboard.
- **Choose test versus live mode** where the provider offers it. Always validate the
  full flow in test/sandbox mode first.

Each enabled gateway exposes a public callback route of the form
`/…/{plugin_name}` that the payment provider calls back into after a transaction to
report its result.

## Security — read before going live

Payment integrations concentrate risk in a few specific places. For synpay:

- **Store each gateway's merchant secret as a real secret.** Keep keys in an
  environment variable or a Key entity, not in committed configuration or code.
- **Operate strictly over HTTPS.** Credentials and callbacks must never travel over
  plain HTTP.
- **Confirm the callback signature is verified server-side before an order is marked
  paid or fulfilled.** Each provider verifies the gateway's callback using that
  gateway's signature scheme — typically a keyed MD5 such as `md5(… . secret)` that
  the provider computes and compares. Do not trust an unverified callback: an order
  should only be treated as paid once the signature check passes. Review the specific
  provider you are using to confirm this verification is in place for your gateway.
- **Confirm test versus live mode** before opening the gateway to real customers, so
  you do not accidentally take (or fail to take) real payments during testing.

Save the form once your gateway is configured, then run a full test transaction to
confirm both the redirect out to the gateway and the callback back into your site
work as expected.
