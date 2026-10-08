# Configuration

The one setting that matters is the **endpoint key** (the token). Setting it is
the first and most important configuration step.

## Set the endpoint key

You can set the key either through the settings form or in `settings.php`.

**Via the settings UI:** log in as a user with **Administer site configuration**,
open the Monitoring Endpoint settings form, and enter a strong, random token as
the endpoint key. Save.

**Via `settings.php`:** you can also define the key in code, which keeps it out of
exported configuration. Read it from an environment variable so the secret is not
committed:

```php
$config['monitoring_endpoint.settings']['endpoint_key'] = getenv('MONITORING_ENDPOINT_KEY');
```

On this project, store the value with DDEV's dotenv helper (never committed) and
restart so the container picks it up:

```bash
ddev dotenv set .ddev/.env --monitoring-endpoint-key=<a-long-random-token>
ddev restart
```

The flag becomes the environment variable `MONITORING_ENDPOINT_KEY`.

Choose a long, random token — treat it like a password, because anyone who has it
can read your site's health data.

## Point your monitor at the endpoint

Configure your monitoring tool to poll:

```
https://your-site.example/monitoring/status?token=YOUR-TOKEN
```

The JSON response contains a `count_failures` count and a status for each enabled
sensor (and, where configured, individual Ultimate Cron job statuses). Some
common setups:

- **Uptime Kuma** — use an *HTTP(s) - JSON Query* monitor. To watch one sensor,
  query something like `$.cron_job_example = OK`. To watch all of them at once,
  compare the count of non-OK/INFO sensors against `count_failures`.
- **Nagios / Icinga** — parse the `count_failures` value and alert when it is
  greater than zero.
- **Custom scripts** — parse the JSON in any language.

## Caching

Responses are **uncached by default** so monitors always see real-time status.
The module offers an optional response cache if you would rather trade freshness
for load; leave it disabled unless you have a reason to enable it.

## Lock it down

- **Set a key** — the single most important step, as above.
- **Serve the endpoint only over HTTPS** so the token is not exposed in transit.
- **Treat the token as a bearer secret** — rotate it if it may have leaked, and
  keep it out of your repository.
