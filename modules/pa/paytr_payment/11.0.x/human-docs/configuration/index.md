# Configuration

There are two parts to configuring PayTR: the **payment gateway** (where your
merchant credentials live) and an optional **installment settings form**.

## 1. Add the PayTR payment gateway

1. Log in as a user who can administer Commerce payment gateways.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway** and choose **PayTR** (off-site redirect).
4. Enter the three values from your PayTR Merchant Panel:
   - **Merchant ID**
   - **Merchant Key**
   - **Merchant Salt**
5. Set the mode (test/live) and the usual Commerce gateway options, then save.

These credentials are entered on the **gateway plugin**, which is gated by the
Commerce payment-gateway administration permission — so only trusted
administrators can see or change them.

### Keep the merchant key and salt secret

The Merchant Key and Merchant Salt are what make the callback signature
trustworthy — treat them as secrets. Prefer storing them in environment variables
rather than committing them, for example with DDEV:

```bash
ddev dotenv set .ddev/.env --paytr-merchant-key=<value>
ddev dotenv set .ddev/.env --paytr-merchant-salt=<value>
ddev restart
```

(Keep `.ddev/.env` out of version control.) Review your configuration export
before committing so real credentials are not written into the exported gateway
config.

## 2. Installment options (optional)

The settings form at **`/admin/commerce/config/paytr-settings`** lets you set an
**installment option per product-collection taxonomy term** — for example: allow
all installment plans, force a single payment, or cap the number of installments
(from 2 up to 12) for products in a given collection.

> **Hardening note for site builders:** this installment settings form is, in this
> release, reachable with only the "access content" permission — which is granted to
> anonymous visitors by default — even though it writes configuration. It exposes
> only installment display options (**not** your Merchant Key or Salt, which live on
> the admin-gated gateway above), so the impact is limited to someone tampering
> with installment display. Even so, it is worth re-gating this route to an
> administrative permission (for example *administer commerce_payment_gateway*) in a
> small custom module until the project ships a fix.

## How the callback confirms payment

You do not configure the callback — it is automatic — but it is worth
understanding. PayTR POSTs its result to `/paytr-payment/callback`. The module
recomputes an HMAC-SHA256 signature over the order reference, salt, status, and
amount (keyed with your Merchant Key) and only marks the order and payment
**completed** when that hash matches the callback's hash **and** the status is
`success`; otherwise the order is **canceled**. This is why the Merchant Key and
Salt must be correct and kept secret — they are what prove a callback is really
from PayTR and that the amount was not altered.

## Test before going live

Run a full test purchase, complete the PayTR iFrame checkout, and confirm the
order moves to *completed* on a successful callback (and *canceled* on a failed
one) before switching to live credentials.
