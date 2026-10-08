# Configuration

Setting up Perfect Money is a two-step process: first tell Basket that Perfect
Money is one of your payment options, then enter your gateway credentials.

## Step 1 — Create the Basket payment point

1. Log in as a user who can administer your Basket store.
2. Go to **Store → Payment settings** (`/admin/basket/settings-payment`).
3. Create a payment point and select **Perfect Money** as its service.
4. After saving, Basket shows a button that takes you to the gateway's own
   settings page — or navigate to it directly (Step 2).

## Step 2 — Enter your Perfect Money credentials

1. Go to **Configuration → Development → Perfect Money**
   (`/admin/config/development/perfectmoney`). This form requires the
   `access perfectmoney settings` permission, so grant it only to trusted store
   administrators.
2. Fill in the settings:
   - **Payee account** — your Perfect Money account number that receives the
     funds.
   - **Passphrase** — the secret passphrase from your Perfect Money account.
     This is the shared secret that makes the return callback unforgeable: the
     module hashes it together with the returned amount and compares the result
     to the gateway's `V2_HASH` before marking an order paid. If it is wrong or
     empty, legitimate payments will not verify. Treat it like a password.
   - **Test mode** — enable this to trial the full redirect-and-return flow
     before you go live. Switch it off once you are confident the flow works.
3. Save the form.

## A note on storing the passphrase securely

The settings form stores the payee account and passphrase in Drupal
configuration. If you export configuration to a Git repository, those values
travel with it — so avoid committing real production credentials. The safer
pattern is to keep the secret out of version control and inject it from the
environment:

```bash
ddev dotenv set .ddev/.env --perfectmoney-passphrase='<your-passphrase>'
ddev restart
```

Keep `.ddev/.env` out of Git. Where the module or your settings allow it,
reference the variable via `getenv('PERFECTMONEY_PASSPHRASE')` (or a
[Key](https://www.drupal.org/project/key) entity using the env provider) rather
than pasting the secret straight into the form on production.

## Going live

When test mode is off and your credentials are correct, a shopper checking out
through Basket is redirected to perfect.money to pay and returned to your site,
where the module verifies the signed status and completes the order only on a
valid, correctly-hashed callback. Because your site contacts perfect.money over
the network, make sure outbound HTTPS to the gateway is allowed by any egress
firewall.
