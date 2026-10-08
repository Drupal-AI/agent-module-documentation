# Configuration

There is no global settings form. You configure Commerce Authorize.net by adding a
**payment gateway** and entering your Authorize.Net credentials on it. Each gateway is
a `commerce_payment_gateway` config entity.

## Add a payment gateway

1. Log in as a user who can administer Commerce.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
3. Give it a **Name** (e.g. "Credit card") and, under **Plugin**, choose one of the
   Authorize.net options:

   | Plugin | When to use it |
   |--------|----------------|
   | **Authorize.net (Accept.js)** | The recommended choice. On-site card form; the card is tokenized in the browser so it never hits your server. |
   | **Authorize.net (Accept Hosted)** | Authorize.Net's own card form shown in a secure iframe on your checkout. |
   | **Authorize.net eCheck** | ACH / bank-account (eCheck) payments. |
   | **Authorize.net (Visa Checkout)** | Legacy and **deprecated** — do not use on new stores. |

4. Set the **Mode** to **Test** while you set things up, or **Live** once your
   credentials are verified and you are ready to take real money.

## Enter your API credentials

Every Authorize.net gateway asks for three values from your Authorize.Net account
(find them under **Account → Security Settings → API Credentials & Keys** in the
Authorize.Net merchant interface):

- **API Login ID** (`api_login`) — your account's public login identifier.
- **Transaction Key** (`transaction_key`) — a **secret**. Treat it like a password.
- **Client Key** (`client_key`) — the public client key that Accept.js uses in the
  browser.

For a **test** gateway, generate these from an Authorize.Net *sandbox / developer*
account (https://developer.authorize.net) rather than your live account.

### Keep the Transaction Key out of plain config

The Transaction Key is a secret and should not be committed to your exported site
configuration. Store it in an environment variable and reference it from
`settings.php` rather than typing it into a value that gets exported. With DDEV:

```bash
ddev dotenv set .ddev/.env --authnet-transaction-key='YOUR_TRANSACTION_KEY'
ddev restart
```

Then, in `settings.php`, override the gateway's configuration from the environment so
the secret lives outside the database and config export — for example:

```php
$config['commerce_payment.commerce_payment_gateway.authnet']['configuration']['transaction_key']
  = getenv('AUTHNET_TRANSACTION_KEY');
```

(Replace `authnet` with the machine name of the gateway you created.) Never hard-code
the key in code or commit it to version control.

## Per-plugin options

Depending on the plugin you chose, a few extra options appear:

- **Accept.js** — **Enable credit card icons** (`enable_credit_card_icons`, on by
  default) shows card-brand icons on the checkout pane. You can also restrict the
  accepted card types (Visa and MasterCard by default; Amex and Discover require
  approval from Authorize.Net on your account).
- **Accept Hosted** — **Require card security code** (`card_code_required`, on by
  default) forces buyers to enter the CVV, and **CAPTCHA security**
  (`captcha_security`, off by default) adds a CAPTCHA to the hosted form.
- **Visa Checkout** (legacy) — asks for a `visa_checkout_api_key`.

The remaining fields (**Display name**, **Payment method types**, **Collect billing
information**, conditions, etc.) are the standard Commerce payment-gateway options.

## Save and test

Click **Save**. With a **test**-mode gateway and sandbox credentials, run a checkout
using Authorize.Net's published test card numbers to confirm authorizations and
captures work. Then, from the order's admin screen you can **capture** an
authorize-only payment, **void** an authorization before it settles, or **refund** a
completed payment.

When everything works in test, edit the gateway, switch **Mode** to **Live**, and
swap in your live-account credentials (keeping the Transaction Key in the environment
as above).

## Going further

Developers can adjust the exact request sent to Authorize.Net — add line items, a PO
number, tax/duty, or customer-profile data — by subscribing to the module's events.
Those are documented for agents in [`agent/api/events.md`](../agent/api/events.md).
