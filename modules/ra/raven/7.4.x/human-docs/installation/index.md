# Installation

## Requirements

- **Drupal 11.1** or newer (`core_version_requirement: ^11.1`).
- The **`sentry/sentry`** PHP SDK (`^4.20`), which Composer installs
  automatically.
- A **Sentry project** (on sentry.io or a self‑hosted Sentry) and its **DSN**
  (client key), which you'll set during configuration.
- **Optional:** the Excimer PHP extension if you want CPU profiling; the CSP,
  Security Kit, Monitoring, or Monolog modules if you want those integrations;
  and Zlib for gzip payload compression.

## Install with Composer

From the project root:

```bash
composer require drupal/raven -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the
`sentry/sentry` SDK and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/raven -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en raven -y
```

There are no submodules.

## A note on the DSN and secrets

Your Sentry DSN can be stored in Raven's config, but it's cleaner (and keeps
secrets out of exported config) to provide it via environment variables. Raven
reads `SENTRY_DSN`, `SENTRY_ENVIRONMENT`, and `SENTRY_RELEASE` from the
environment, and those override the stored values. If you use DDEV, set the DSN
with `ddev dotenv set` and restart, so it's present in the web container.

## Next step

Nothing is sent to Sentry until you set a DSN and enable at least one handler or
log level. Continue to [Configuration](../configuration/index.md).
