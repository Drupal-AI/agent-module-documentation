# Configuration

## Enter your Tap keys and choose the environment

1. Enable the module (`drush en tap_payment`).
2. Go to **Configuration → Web services → Tap Payment**
   (`/admin/config/services/tap-payment`).
3. **Choose the environment** (sandbox or production) and paste the matching **secret
   key**. Tap has no separate sandbox host — the environment is decided simply by
   *which key* you use. The key fields are **write-only**: once saved they are never
   rendered back to you.
4. There is **no webhook URL to register** in Tap's dashboard. The module sends its
   own webhook and return URLs with every charge it creates.

### Keeping secrets out of exported config

Rather than storing the keys in configuration (which can end up in your exported
config), you can set them in `settings.php`, for example:

```php
$config['tap_payment.settings']['live_secret_key'] = getenv('TAP_LIVE_SECRET_KEY');
```

This keeps the secret in an environment variable and out of your repository.

## Permissions

Set these at **People → Permissions**:

- **`administer tap payment`** — configure the credentials and environment. Grant
  only to trusted administrators.
- **`view tap payment transactions`** — read the payment ledger. Grant to whoever
  needs to review payments.

## Review the payment ledger

Every attempted payment is recorded in a local transaction ledger, viewable at the
**transactions** list under the settings page
(`/admin/config/services/tap-payment/transactions`) for users with the *view tap
payment transactions* permission.

## How confirmation works (so you can trust the ledger)

You do not need to configure this, but it is worth understanding: Tap confirms
payments by posting a **signed webhook** to the module, whose HMAC signature is
verified before any value is believed. The browser returning from checkout is *not*
treated as proof — the module re-reads the charge from Tap. Duplicate charges are
prevented by a unique idempotency key, and replayed or out-of-order webhook
deliveries are harmless because the ledger advances through a one-way state machine.
Subscribe to the module's `PAYMENT_CAPTURED` event from your own code to fulfil an
order only once money has actually been taken.

## Advanced operational settings

Timeouts, retry counts, flood limits, the webhook freshness window, idempotency
lifetime and reconciliation parameters all have sensible defaults and are treated as
protocol/operational facts rather than merchant settings. They can be overridden in
`services.yml` if you have a specific need, but most sites never touch them. A
reconciler also runs on cron to re-verify quiet or abandoned checkouts against Tap.

## If keys are missing

The module adds a warning to Drupal's status report (**Reports → Status report**)
when the keys are missing or misconfigured, so keep an eye there after setup.
