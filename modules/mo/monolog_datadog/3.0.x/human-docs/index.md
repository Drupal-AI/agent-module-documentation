# Monolog Datadog — manual setup guide

**Monolog Datadog** (`monolog_datadog`) ships your Drupal logs to
[Datadog](https://www.datadoghq.com/) through the
[Monolog](https://www.drupal.org/project/monolog) module — no Datadog agent
required. It adds a Monolog *handler* that sends log records straight to Datadog's
HTTP intake, plus a processor that maps Drupal's log levels to Datadog's log
statuses, so your application logs land in Datadog alongside your metrics and
traces for centralised search and alerting.

This is a developer/observability integration with **no admin UI and no settings
form**. You wire it up in two places: a Monolog handler definition in your
`logging.services.yml`, and the Datadog API key (plus optional tags) in your
`settings.php`. It depends on the Monolog module and works on Drupal 10.1 through
12.

The Datadog API key is a live credential, and log content — which can include
request data and error details — is transmitted off-site to Datadog, so this guide
covers storing the key safely and being mindful of what you log.

This guide is written for a **human**. If you want terse, token‑cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — setup happens in
`logging.services.yml` and `settings.php`, described below.

## How to set it up

### 1. Deploy in the right order

The handler class only exists once the module is enabled, so if you add the
handler service before the module is on, the container will fail to build with an
error like *Class "Drupal\monolog_datadog\Monolog\Handler\DatadogHandler" does not
exist*. Do it in two steps:

1. Enable the module and deploy that first (see
   [Installation](installation/index.md)).
2. Then add the logging handler (below) and deploy that.

### 2. Add the Datadog handler

In your site's `logging.services.yml` (for example
`sites/default/logging.services.yml`), register the handler and route your
channels to it. The handler takes a Datadog region and the config factory:

```yaml
parameters:
  monolog.channel_handlers:
    default: ['datadog']
    php: ['error_log', 'datadog']
services:
  monolog.handler.datadog:
    class: Drupal\monolog_datadog\Monolog\Handler\DatadogHandler
    arguments: ['EU', '@config.factory']
```

The first argument is the Datadog region — this example uses `EU`; check
`DATADOG_LOG_HOSTS` in the handler for the available regions (for example use the
US host if your Datadog account is US-based).

### 3. Add the API key (as a secret) and optional tags

The Datadog API key and any tags are read from configuration overrides in
`settings.php`. **Treat the API key as a secret** — keep it out of your repository
and out of exported configuration by reading it from an environment variable:

```php
$config['monolog_datadog.settings']['api_key'] = getenv('DATADOG_API_KEY');
$config['monolog_datadog.settings']['ddtags'] = 'env:production,project:example.com';
```

On this project, store the key with DDEV's dotenv helper (never committed) and
restart so the container picks it up:

```bash
ddev dotenv set .ddev/.env --datadog-api-key=<your-datadog-api-key>
ddev restart
```

The flag becomes the environment variable `DATADOG_API_KEY`. Because the handler
calls Datadog's intake over the network, make sure your site's outbound network
allows HTTPS requests to Datadog's log hosts.

### 4. Mind what you log

Log records sent to Datadog can contain request data, errors and potentially
sensitive details. Scrub or avoid logging sensitive data, since it leaves your
site once forwarded.

### 5. Test it

The module ships a Drush command to exercise the logging service:

```bash
drush monolog_datadog:test-logging-services
```

Run it and confirm the test entries appear in your Datadog logs.
