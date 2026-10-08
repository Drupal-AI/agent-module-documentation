# Stripe settings

## Admin form

Route `stripe.settings` → **/admin/config/system/stripe** (permission `administer stripe`,
form `StripeSettingsForm`). Fields:

- **Environment** — radios `test` / `live` (required). Selects which key set is active.
- **Test** and **Live** fieldsets, each with:
  - **Publishable** (text) — the `pk_...` publishable key.
  - **Secret** (password) — the `sk_...` secret key (only overwritten if you type a new value).
  - **Webhook secret** (password) — the `whsec_...` signing secret for
    `/stripe/webhook`; if empty, incoming webhooks are validated by re-fetching the event
    from Stripe instead of by signature.

## Config object `stripe.settings`

```yaml
environment: test          # or 'live'
apikey:
  test:  { public: 'pk_test_…', secret: 'sk_test_…', webhook: 'whsec_…' }
  live:  { public: '',          secret: '',          webhook: '' }
```

Read the active secret key in code as:
`\Drupal::config('stripe.settings')->get('apikey.' . \Drupal::config('stripe.settings')->get('environment') . '.secret')`.

## Set keys with drush

```
drush config:set stripe.settings environment test -y
drush config:set stripe.settings apikey.test.public  'pk_test_xxx' -y
drush config:set stripe.settings apikey.test.secret  'sk_test_xxx' -y
drush config:set stripe.settings apikey.test.webhook 'whsec_xxx'  -y
```

## Security: keep secrets out of config

The form itself warns that this config is exported in plain text and likely version-controlled.
Prefer providing secret keys from the environment in `settings.php`, e.g.:

```php
$config['stripe.settings']['apikey']['live']['secret'] = getenv('STRIPE_SECRET_KEY');
```

so the secret is never written to exported config.

## Front-end library

`hook_page_attachments()` attaches the `stripe/stripe` library (which loads
`https://js.stripe.com/v3/`) on **every** page — intentional, for Stripe's fraud detection.
The publishable key is passed to the browser via drupalSettings by the payment elements.
