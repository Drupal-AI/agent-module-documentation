# Configuration

Monolog-Logz has **no settings form in the admin UI**. Everything is configured
in code — your Logz.io details go into `settings.php` (via Drupal's
configuration override system), and you tell Monolog to actually use the `logz`
handler in a Monolog services file. There are two steps.

## Step 1 — add your Logz.io settings

Add the following to your site's `settings.php` (or a
`settings.local.php`/environment-specific include). These values populate the
`monolog_logz.settings` configuration item that the handler reads:

```php
// Configure the Logz.io shipping handler:
$config['monolog_logz.settings']['token'] = 'my-logzio-token';
$config['monolog_logz.settings']['level'] = 'Debug';
$config['monolog_logz.settings']['host']  = 'UsEast1';
```

Field by field:

- **`token`** — your Logz.io **log-shipping token**, found in your Logz.io
  account. This is a **secret**: it authorises writing logs to your account.
  Never commit it to version control. Prefer supplying it from an environment
  variable — for example `getenv('LOGZIO_TOKEN')` — so the actual value lives
  outside the codebase. With DDEV you can store it with
  `ddev dotenv set .ddev/.env --logzio-token=<value>` and then read
  `getenv('LOGZIO_TOKEN')` in `settings.php` (restart DDEV so the container
  picks it up).
- **`level`** — the minimum severity to ship, using a Monolog level name such as
  `Debug`, `Info`, `Notice`, `Warning`, or `Error`. `Debug` ships everything;
  raise it (for example to `Warning`) in production to reduce volume and cost.
- **`host`** — your Logz.io **data-shipping region**, expressed as the region
  identifier the `logzio-monolog` library expects (for example `UsEast1`). Pick
  the value that matches the region of your Logz.io account so logs reach the
  correct endpoint.

## Step 2 — tell Monolog to use the handler

Registering the settings is not enough on its own — you must add the `logz`
handler to the Monolog channels you want shipped. This is done in the Monolog
services file you already maintain for the Monolog module (commonly
`sites/default/monolog.services.yml`), which must also be registered in
`settings.php`:

```php
// Part of the Monolog module setup:
$settings['container_yamls'][] = 'sites/default/monolog.services.yml';
```

Then, in that YAML file, map the `logz` handler onto your channels:

```yaml
parameters:
  monolog.channel_handlers:
    php: ['error_log', 'logz']
    default: ['logz']
```

Here the `php` channel logs to both the PHP error log and Logz.io, while every
other channel ships to Logz.io via `default`. Adjust the mapping to match which
channels you want forwarded. See the Monolog module's README for the full syntax
of `monolog.channel_handlers`.

## After changing configuration

Rebuild the container/cache so Drupal picks up the new services and settings:

```bash
drush cr
```

## A note on log content and privacy

Everything shipped by these handlers leaves your server and is stored on
Logz.io. Log records can contain request data, error details, user identifiers,
and — if code logs them — secrets. Keep the shipping token secret, ship over the
region's secure endpoint, and practise good log hygiene: avoid logging passwords,
tokens, or personal data, and scrub anything sensitive before it is logged.
