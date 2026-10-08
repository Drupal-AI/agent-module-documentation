# Configuration

Bitaps Payment is set up in its settings form and then exposed as a Basket payment
method. Because it handles payments, take the security section at the end seriously.

## 1. Enter the Bitaps credentials

Go to **Configuration → Development → Bitaps** (`/admin/config/development/bitaps`),
which requires the `access bitaps settings` permission. Enter your Bitaps
credentials, including the **secret key**, and select the currency to accept.

### Keep the secret key confidential

The secret key is used to verify callbacks from Bitaps, so it is a credential. Keep it
out of any configuration you publish or commit publicly. Where you manage
configuration in version control, prefer supplying the value from an environment
variable. With DDEV:

```bash
ddev dotenv set .ddev/.env --bitaps-secret-key=YOUR_SECRET_HERE
ddev restart
```

Never commit `.ddev/.env`, and confirm it is set without printing it:

```bash
ddev exec 'test -n "$BITAPS_SECRET_KEY" && echo set || echo missing'
```

## 2. Expose the payment method in Basket

In Basket, enable and expose the Bitaps payment method (`BasketBitaps`) so customers
can choose it at checkout.

## 3. How payment flows

- The customer completes payment on the hosted page the module serves under
  `/bitaps/...`.
- Bitaps then calls back to the module's status endpoint, which checks a SHA-256 hash
  built from the payment and the secret key before updating the payment record.
- On a confirmed payment, the module notifies Basket to finish the order.

## Operating notes — taking real payments

The payment-status callback authenticates Bitaps with a SHA-256 hash built from the
payment data and your secret key, so keep the secret key confidential and never commit
it to version control. Serve the whole site over HTTPS so the callback and the checkout
pages cannot be observed in transit. As with any payment integration, test the full
flow against Bitaps' sandbox before accepting real funds, and review the maintainers'
project page for the current release status.
