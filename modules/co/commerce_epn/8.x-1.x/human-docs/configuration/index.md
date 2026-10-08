# Configuration

Commerce eProcessingNetwork is configured on the payment‑gateway form — there is
no separate settings page.

## Add the gateway

1. Log in as a user who can administer Commerce.
2. Go to **Administration → Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
3. Choose the **eProcessingNetwork gateway** plugin.

## Fill in the fields

- **Username** — your EPN account id (`ePNAccount`). The shipped sandbox test
  value is `080880`.
- **Restrict Key** — the RestrictKey from your EPN back office. The shipped
  sandbox test value is `yFqqXJh9Pqnugfr`.
- **Test mode** — a toggle for use on a production account.

Because this is an **on‑site** gateway, the card fields render on your own
checkout. Make sure the site runs over **HTTPS** and be aware that card numbers
passing through your site put you in **PCI** scope (only the last four digits are
retained locally).

## ⚠️ Replace the shipped sandbox credentials

The module ships with EPN's **public** sandbox credentials as defaults
(`080880` / `yFqqXJh9Pqnugfr`) so a new gateway works against the test account
immediately. These are known to everyone — **you must replace them with your own
EPN account** before taking real payments.

## Keep live credentials out of the gateway UI

The maintainers recommend **not** storing your live username and Restrict Key in
the payment‑gateway UI, because those values are exported with configuration and
can end up used on test/development copies of the site. Instead, override them in
`settings.local.php` (which is not shared between environments):

```php
$config['commerce_payment.commerce_payment_gateway.eprocessingnetwork']['configuration']['username'] = '123456789';
$config['commerce_payment.commerce_payment_gateway.eprocessingnetwork']['configuration']['restrict_key'] = 'xyz123456789';
$config['commerce_payment.commerce_payment_gateway.eprocessingnetwork']['configuration']['mode'] = 'live';
```

Adjust the gateway machine name in the config key to match the gateway you
created. Keep `settings.local.php` (and any environment file holding these values)
out of version control.

## Transaction lifecycle

Once live, the gateway drives the standard EPN operations server‑to‑server:
**Store** (tokenise a card, keeping only the last four digits locally), **Sale**
or **AuthOnly** at checkout, **capture** a prior authorisation, **void** before
capture, and **refund** a completed payment. The amount sent to EPN is always the
order/payment amount — never a client‑supplied value — and there is no return or
notify route, so there is no unauthenticated callback an attacker could use to
complete an order.
