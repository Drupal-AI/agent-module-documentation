# Configuration

Bambora is configured the same way as any Drupal Commerce payment gateway — you
add a gateway of the Bambora type and enter your merchant details.

## Add the payment gateway

1. Log in as a user who can administer Commerce.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Choose **Add payment gateway**, give it a name, and select the **Bambora**
   plugin as its type.

## Enter the merchant credentials

On the gateway form, supply the Bambora **merchant ID** and **API credentials**
from your Bambora account. As covered in
[Installation](../installation/index.md), source these from environment variables
rather than typing the raw secrets into tracked configuration — use
`getenv()` in `settings.php`, or a Key entity backed by the environment variable
where the field supports one. Nothing secret should end up in a configuration
export or database dump.

## Choose the mode and options

- Set the gateway **mode** to *test* while you are integrating, and switch it to
  *live* only when you are ready to take real payments.
- Enable the payment methods you offer (Interac Online, card).

Save the gateway. It then appears as a payment option during Commerce checkout.

## How completion is protected

You do not need to configure anything for this, but it is worth understanding:
when a customer returns from Bambora, the order is **not** marked paid based on
the returned request parameters. The module makes a server-side API call back to
Bambora (`continuePayment()`) using your merchant credentials to confirm the
payment, and uses the order's own server-side total as the amount. A forged
return URL therefore cannot mark an order paid. This is built in — your job is
simply to keep the merchant credentials secret and correct.

## Test before going live

With the gateway in test mode, run a full checkout through Bambora's test
environment and confirm the order is only completed after a genuine payment.
Then switch the gateway to live mode.
