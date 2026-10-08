# Configuration

Setting up Monolog Loki has two parts: telling the module **where your Loki
endpoint is** (plus any credentials and labels), and telling **Monolog to
actually use the Loki handler** for the channels you want shipped. The
connection and labels can be set in the admin UI or in `settings.php`; the
channel wiring is done in your Monolog services file.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to the Monolog Loki settings form under **Configuration** and fill in the
   Loki connection and labels described below.

## The Loki connection settings

- **Loki push URL / entrypoint** — the base URL of your Loki instance's push
  API (the endpoint that accepts log pushes). Use an **HTTPS** URL so log data
  is encrypted in transit. Point it at your self-hosted Loki or your Grafana
  Cloud Loki endpoint.
- **Credentials (username / password or token)** — if your Loki endpoint
  requires authentication (Grafana Cloud does), enter the credentials here.
  These are **secrets** — see "Keeping credentials out of config" below.
- **Labels** — the Loki labels attached to every pushed log stream (for example
  a `job`, `app`, or `environment` label). Labels are how you'll find and filter
  these logs in Grafana, so choose values that identify this site/environment.
  Keep the label set small and low-cardinality, as Loki recommends.

## Setting values in settings.php instead

Because the credentials and labels can also be defined in `settings.php`, you
can keep the secret out of the exported configuration and supply it per
environment. Override the module's configuration like this:

```php
$config['monolog_loki.settings']['url'] = 'https://loki.example.com';
$config['monolog_loki.settings']['credentials']['password'] = getenv('LOKI_TOKEN');
```

(Use the actual keys shown on the settings form / in the module's README.)
Reading the secret from `getenv()` keeps it out of the codebase. With DDEV you
can store it with `ddev dotenv set .ddev/.env --loki-token=<value>` and then read
`getenv('LOKI_TOKEN')` here (restart DDEV so the container picks it up).

## Wire the handler into Monolog

As with all Monolog handlers, defining the connection is not enough — you must
add the Loki handler to the channels you want shipped, in the Monolog services
file you maintain for the Monolog module (commonly
`sites/default/monolog.services.yml`, registered in `settings.php` via
`$settings['container_yamls'][]`). Map the Loki handler onto your channels'
`monolog.channel_handlers` as described in the Monolog module's README and this
module's own README.

## After changing configuration

Rebuild the cache/container so the new settings and services take effect:

```bash
drush cr
```

## A note on log content and privacy

Everything shipped leaves your server and is stored in Loki. Log records can
contain request data, error details, user identifiers, and — if code logs them —
secrets. Use an authenticated, TLS (HTTPS) endpoint, store the Loki credentials
as secrets, and practise good log hygiene: avoid logging passwords, tokens, or
personal data, and scrub anything sensitive before it is logged.
