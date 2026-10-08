# Configuration

All of Paypal Plus's settings live on one form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **`/admin/paypal-configurations`** (route `paypal_plus.configurations`).

The values you enter here are stored in the `paypal_plus.settings` configuration
object.

## The fields

- **Sandbox mode** — a toggle that decides whether payments go to PayPal's test
  (sandbox) environment or the live environment. Keep this on while you test, then
  switch it off for production.
- **Sandbox client ID / secret** — the REST API app credentials from your PayPal
  developer account's *sandbox* app. Used when sandbox mode is on.
- **Live client ID / secret** — the credentials from your *live* PayPal app. Used
  when sandbox mode is off.
- **Currency** — the currency code (for example `USD`, `EUR`) that amounts are
  charged in. This can also be overridden per call by the
  `hook_paypal_plus_currency_code()` hook.

The module keeps TLS certificate verification **on** by default for its calls to
PayPal (`CURLOPT_SSL_VERIFYPEER` defaults to true), so traffic to the PayPal API
is properly validated — do not disable it.

## Keep the client secret out of exported config

Your PayPal **client secret** is live credential material. Treat it as a secret:

- Store the value in an environment variable rather than typing it into a file
  that gets committed. With DDEV:

  ```bash
  ddev dotenv set .ddev/.env --paypal-live-secret=<value>
  ddev restart
  ```

  (Keep `.ddev/.env` out of version control.)
- Review your configuration export (`drush config:export`) before committing —
  make sure a real client secret is not sitting in `paypal_plus.settings.yml` in
  your repository.

## Save and test

Click **Save configuration**. Then, with **Sandbox mode** enabled, run a test
payment end to end — enter an amount, complete the PayPal sandbox checkout, and
confirm you land back on the site with a success result. Only switch to live
credentials once the sandbox flow works.
