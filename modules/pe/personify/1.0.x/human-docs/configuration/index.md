# Configuration

Personify has **no settings form in the admin UI**. You configure it by setting
configuration overrides under the `personify.settings` key in your site's
`settings.php` (or, better, in a per‑environment settings file that reads from
environment variables). These values tell the module which Personify service to
talk to and how to authenticate.

## The settings

Add a block like this to `settings.php`, filling in the values Personify gave you:

```php
# Personify SSO / vendor data.
$config['personify.settings']['prod_wsdl']        = '';  // Production WSDL URL
$config['personify.settings']['stage_wsdl']       = '';  // Staging WSDL URL
$config['personify.settings']['vendor_id']        = '';
$config['personify.settings']['vendor_username']  = '';
$config['personify.settings']['vendor_password']  = '';
$config['personify.settings']['vendor_block']     = '';

# Personify Production endpoint.
$config['personify.settings']['prod_endpoint']    = '';
$config['personify.settings']['prod_username']     = '';
$config['personify.settings']['prod_password']     = '';

# Personify Staging endpoint.
$config['personify.settings']['stage_endpoint']   = '';
$config['personify.settings']['stage_username']    = '';
$config['personify.settings']['stage_password']    = '';
```

What each group is for:

- **`prod_wsdl` / `stage_wsdl`** — the WSDL URLs that describe Personify's SOAP
  service for your production and staging environments.
- **`vendor_id`, `vendor_username`, `vendor_password`, `vendor_block`** — the
  vendor/SSO credentials Personify issues you for single sign‑on.
- **Production endpoint** (`prod_endpoint`, `prod_username`, `prod_password`) — the
  live Personify service URL and the username/password used to authenticate to it.
- **Staging endpoint** (`stage_endpoint`, `stage_username`, `stage_password`) — the
  equivalent values for Personify's stage service, so a non‑production environment
  can be pointed at the test system.

Typically your production settings file fills in the production endpoint and your
development/staging settings file fills in the staging one.

## Keep the credentials out of version control

These are **secrets** — vendor credentials and endpoint passwords that grant
access to member data. Do not commit real values to your repository. Instead:

1. Store each value in an **environment variable**. With DDEV, use the built‑in
   dotenv command, for example
   `ddev dotenv set .ddev/.env --personify-vendor-password=<value>` (keep
   `.ddev/.env` out of version control), then `ddev restart`.
2. Read them in `settings.php` with `getenv()`:

   ```php
   $config['personify.settings']['vendor_password'] = getenv('PERSONIFY_VENDOR_PASSWORD');
   ```

This keeps the credentials in the environment rather than in tracked files, while
still populating `personify.settings` for the module.

## Data‑handling reminder

The Personify integration exchanges **member personal data (PII)** with an
external service. Make sure the endpoints are **HTTPS**, and handle the data you
receive in line with your organization's privacy obligations. The module has no
access‑control role of its own — it simply carries the connection.
