# Configuration

Configuring VictoriaBank has two parts: placing the RSA key files, then adding the
payment gateway.

## 1. Generate and place the PEM key files

VictoriaBank uses RSA signatures, so the module needs three PEM files in your
site's **private** file system.

1. Contact a **VictoriaBank manager** to receive the integration instructions and
   the bank's public key.
2. **Generate your own public/private key pair** as instructed by the bank.
3. Create a folder named **`vicb_pem`** inside your private file system —
   `private://vicb_pem`.
4. Copy these three files into that folder:
   - `key.pem` — your private key.
   - `pubkey.pem` — your public key.
   - `victoria_pub.pem` — the bank's public key (used to verify callbacks).

Because `key.pem` is your private key, keep it in the **private filesystem** (never
under the web root) and never commit it to version control. The module reads
`key.pem` and `victoria_pub.pem` directly from `private://vicb_pem/`; treat any
additional credentials the bank gives you (merchant/terminal IDs) as sensitive and
keep exported site config out of public version control.

## 2. Add the payment gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Choose the **VictoriaBank** plugin.
3. Configure it per the bank's integration instructions (merchant identifiers, mode,
   and so on).
4. Set the gateway **mode** to test while you set up, then switch to live for
   production.
5. Save.

## 3. Callback URL

Give VictoriaBank this callback (notification) URL for your site:

```
https://yourdomain.com/commerce-vb-md/callback
```

The bank posts the signed payment result to this URL after checkout. The module
verifies the bank's `P_SIGN` signature (RSA, using `victoria_pub.pem`) before
completing the order.

## Test vs live

Complete a **test payment** end to end and confirm the callback arrives, the
signature verifies, and the order is marked paid. Then switch to live mode.

## Security recap

- The callback is **signature‑verified**: the module runs
  `openssl_public_decrypt()` with the bank's public key and compares the decrypted
  MAC, so a forged callback cannot mark an order paid.
- Keep `key.pem` and all credentials in the **private filesystem** / environment,
  never in the web root or version control.
- Serve the site over HTTPS.
