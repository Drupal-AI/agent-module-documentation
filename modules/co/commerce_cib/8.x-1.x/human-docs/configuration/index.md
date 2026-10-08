# Configuration

CIB is configured like any Commerce payment gateway, with one unusual step: you
place the bank's **DES keyfiles** on your server and tell the gateway where they
are.

## Place the DES keyfiles

CIB issues you separate **test** and **live** DES keyfiles. Copy them onto your
server at absolute paths the web server can read but that are **not publicly
downloadable** — keep them outside the web root, or otherwise protected, and set
restrictive file permissions. These keyfiles are the secret that encrypts and
decrypts your SAKI messages, so treat them like any other payment credential:
never commit them to version control, and restrict who can read them.

## Add the gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Give it a name and display label, and choose the **CIB** plugin.
3. Enter the details:
   - **CIB Shop ID (PID)** — your merchant identifier from CIB (e.g. `ABC0001`).
   - **Currency** — HUF or EUR (fixed per the form).
   - **Test keyfile path** — the absolute server path to the test DES keyfile.
   - **Live keyfile path** — the absolute server path to the live DES keyfile.
   - **Mode** — test/live; this selects both which keyfile and which SAKI endpoint
     are used.
4. Save.

## How a payment is confirmed (and why it's safe)

- The redirect request is built and **DES‑encrypted with your keyfile**, then the
  customer is sent to CIB's SAKI page over **HTTPS**.
- On return, the module decrypts the response and, for a completed message, issues
  its **own server‑to‑server "close transaction" (MSGT32) query** to CIB and reads
  the authoritative reply.
- It loads the local payment, **checks the returned amount equals the stored
  amount**, and only then sets the order to completed (otherwise voided/pending).

Because confirmation is done server‑side and the amount is verified against the
order, a tampered browser return cannot complete an order for free, and there is no
client‑settable amount.

## Refunds

The gateway supports refunds through Commerce (full and partial). Refunds are **HUF
only** with a **100‑HUF minimum**, and drive CIB's status‑and‑refund message
sequence depending on whether the transaction was authorized or captured, setting
the payment to refunded or partially refunded.

## Transport note to be aware of

The customer‑facing checkout uses **HTTPS**, and all SAKI payloads are
**DES‑encrypted at the application layer**. However, the module contacts CIB's
server‑to‑server "market" channel (the close/refund queries) over **cleartext
HTTP** on a non‑standard port (`http://eki.cib.hu:8090` / `http://ekit.cib.hu:8090`).
This is by CIB's protocol design — the message contents are encrypted regardless of
the transport — but it's worth knowing when reviewing your firewall rules and
egress traffic. It is not a client‑facing exposure and does not put card data or
the payment confirmation at risk.

## Notifications

The module ships event subscribers that email or notify on failed initialization,
failed payment, timeout, no‑communication, and order‑paid events, so you and/or the
customer are kept informed of outcomes. No extra configuration is required for
these beyond a working mail setup.
