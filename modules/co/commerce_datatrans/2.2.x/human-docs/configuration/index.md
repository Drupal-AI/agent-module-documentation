# Configuration

Datatrans is configured like any Drupal Commerce payment gateway. The credentials
are entered directly on the gateway plugin's settings form. The one field that is
easy to overlook is the **`sign2` signing key**, because that is what makes the
webhook verification active.

## The credentials you need

From your Datatrans account you need three values:

- **Merchant-ID** — your unique Datatrans merchant identifier.
- **Password** — the Server-to-Server (UPP security) password. Together with the
  Merchant-ID this authenticates the module's API calls to Datatrans.
- **Webhook Sign Key (`sign2`)** — the HMAC key used to verify webhook
  notifications. Required only if you use the webhook, but you should use it.

These are credentials — treat them as secrets. Do not paste them into issues or
commit an exported configuration that contains them to a public repository; use
your normal secrets/config-management workflow (for example, keep the gateway
configuration out of exported config, or override it per-environment) so the
values are not stored in version control.

## Add the payment gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Give it a **Name** and choose the **Datatrans** plugin.
3. Enter your **Merchant-ID** and **Password**.
4. Enter the **Webhook Sign Key (`sign2`)**. Without it the webhook returns `403`
   and cannot confirm payments asynchronously (see the notes below). The field's
   description shows the exact **webhook URL** to register in the Datatrans backend.
5. Optionally enable **Automatically settle the payment**, **Use Alias** (for
   recurring/card-on-file payments), and **Initiate the initial payment without
   amount** (needed for some alias flows such as Twint/PayPal).
6. Choose the **mode** — use Datatrans **test** credentials (sandbox) while
   integrating and switch to **production** only after a successful end-to-end test.
7. Enable the gateway and save.

Make sure a **payment method** exists in Commerce (**Store → Configuration →
Payment methods**) so the gateway is offered at checkout.

## Register the webhook in Datatrans

The webhook is a single, static URL per merchant, configured in the Datatrans
backend (Server-to-Server settings). Copy the URL shown in the **Webhook Sign Key**
field's description on the gateway form and register it in Datatrans. The same
`sign2` key you enter here must match the one Datatrans uses to sign notifications.

## Test before you go live

Datatrans provides test credentials. Run a full purchase — the redirect, the
browser return, and the asynchronous webhook — and use the module's logging to
confirm the notification was received and verified before switching to production.

## How payment confirmation works

- **On the browser return**, the module reads the transaction status directly from
  Datatrans over an authenticated API call and records the Commerce payment.
- **The webhook** independently confirms the result server-to-server. It is
  HMAC-authenticated and fails closed: it requires the `sign2` key (returns `403`
  if it is missing), reads the `Datatrans-Signature` header, recomputes the HMAC
  over the request body, and **rejects** the request if the header is absent or the
  signature does not match. Only then does it process the payment, and only for
  whitelisted statuses (`settled`, `transmitted`, `authorized`).

Because the webhook cannot be processed without a valid signature, keeping your
`sign2` key confidential is the meaningful protection — and remember the webhook is
only active once `sign2` is set.
