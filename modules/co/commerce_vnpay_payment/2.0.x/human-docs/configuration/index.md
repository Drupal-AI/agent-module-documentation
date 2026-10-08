# Configuration

Commerce VNPay is configured the same way as any Drupal Commerce payment
gateway: you create a gateway entity and fill in your VNPay credentials.

## Add the payment gateway

1. Log in as a user who can administer Commerce.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway**, give it a name (for example "VNPay"), and
   choose **VNPay** as the plugin.

## Gateway settings, field by field

- **vnp_Url** — the VNPay payment endpoint. Use VNPay's **sandbox** URL while you
  test and switch to the **production** URL only when you go live. Test the full
  redirect loop in the sandbox first.
- **vnp_TmnCode** — your VNPay terminal / merchant code, issued by VNPay.
- **vnp_HashSecret** — the secret key VNPay gives you. It is used to sign the
  outbound request (HMAC‑SHA512) and must be kept confidential.
- **Mode / status** — the standard Commerce gateway options let you mark the
  gateway as test or production and enable or disable it.

When the customer checks out, the module builds the request URL, signs it with
your `vnp_HashSecret`, and redirects to `vnp_Url`. It passes the order id, the
amount (×100), the currency, billing name/address/email when a billing profile
exists, a 15‑minute expiry, and the locale derived from the current language.

## Handle the secret safely

The `vnp_HashSecret` (and any other VNPay credential) is a secret. Never commit
it to code. On DDEV, store it in an environment variable and reference it through
a **Key** entity rather than pasting it into exported configuration:

```bash
ddev dotenv set .ddev/.env --vnpay-hash-secret=<value>
ddev restart
```

Then create a Key with the built‑in environment provider and point the gateway's
secret at it where the field allows a Key reference. Always serve the site over
**HTTPS**.

## Security caveat — read before going live

As noted in the [overview](../index.md), the current return handler trusts
VNPay's success response code without re‑verifying the returned `vnp_SecureHash`,
and there is no server‑to‑server notification (IPN). A customer could forge a
"paid" return and mark their own order complete. Treat this gateway as **test
only** until return‑signature verification and a server‑side notify handler are
in place. Do not rely on it for real money as‑is.

## Save

Click **Save** to store the gateway. Place a test order through VNPay's sandbox
and confirm the redirect out, the return to checkout, and the resulting Commerce
payment all behave as expected before switching to production credentials.
