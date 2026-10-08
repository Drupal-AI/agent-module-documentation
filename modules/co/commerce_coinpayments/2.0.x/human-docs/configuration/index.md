# Configuration

CoinPayments is configured like any Commerce payment gateway, with one extra step:
granting the IPN permission so CoinPayments' servers can reach the callback.

## Store your keys and IPN secret securely

The gateway needs your CoinPayments **merchant id**, **public/private API keys**,
and **IPN secret**. Keep the secrets out of version control. On a DDEV site, store
them in environment variables:

```bash
ddev dotenv set .ddev/.env --coinpayments-private-key=<value>
ddev dotenv set .ddev/.env --coinpayments-ipn-secret=<value>
ddev restart
```

(`.ddev/.env` must stay out of version control.) Reference them through **Key**
entities where practical. The **IPN secret is the most important one to protect** —
it is what keys the signature verification that makes callbacks trustworthy.

## Add the gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Give it a name and display label, and choose the CoinPayments plugin (labelled
   for paying with Bitcoin, Litecoin, and other cryptocurrencies — off‑site
   redirect).
3. Enter your **Merchant ID**, **public/private API keys**, and **IPN secret**.
4. Choose test/sandbox mode first, and save.

## Grant the IPN permission

Under **People → Permissions**, grant **`access commerce coinpayments ipn`** to the
**anonymous** role. This is required so CoinPayments' servers can POST to
`/commerce_coinpayments/ipn`. Granting it to anonymous is expected and safe here —
see the security note below.

## How confirmation is secured

- When CoinPayments calls the IPN endpoint, the handler recomputes
  `hash_hmac('sha512', <raw POST body>, <IPN secret>)` and compares it to the
  `HMAC` request header, and validates the merchant id, currency, and amount before
  the order is completed. A forged or replayed IPN without the correct secret fails
  verification and does nothing.
- **The permission is not the security boundary — the signature is.** The IPN route
  is anonymous‑reachable on purpose (so CoinPayments can hit it); it is safe because
  the HMAC‑SHA512 signature check, keyed with your IPN secret, is what actually
  authorizes the callback. So keep the IPN secret confidential, and don't be
  alarmed that anonymous users can reach the endpoint.

## Test before going live

Put the gateway in sandbox mode, create a store and a test product, run an order
through to CoinPayments, complete the payment, and confirm the order moves to
completed via the IPN. Only then switch to live mode.
