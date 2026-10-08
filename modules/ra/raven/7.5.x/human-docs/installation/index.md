# Installation

## Requirements

- **Drupal 11.1 or newer** (`core_version_requirement: ^11.1`).
- The **Sentry PHP SDK** (`sentry/sentry` `^4.20`), installed automatically with
  Composer.
- A **Sentry project and DSN** — from the hosted service at sentry.io, or a
  self-hosted Sentry / Relay / GlitchTip / Bugsink instance.
- *(Optional)* the **Excimer** PHP extension if you want CPU profiling / flame
  graphs.

## Install with Composer

From the project root:

```bash
composer require drupal/raven -W
```

This installs both the module and the Sentry PHP SDK. The `-W`
(`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/raven -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en raven -y
```

The module ships **no submodules**.

## Verify it worked

Log in as an administrator and go to **Configuration → Development → Logging and
errors** (`/admin/config/development/logging`). You should see a **Raven** section
added to the core Logging form. Remember that nothing is sent to Sentry until you
enter a DSN and enable at least one handler or log level — see
[Configuration](../configuration/index.md). After configuring, you can send a test
event with the module's Drush command to confirm the connection.
