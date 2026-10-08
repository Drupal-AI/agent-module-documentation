# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- No modules outside Drupal core and no third‑party libraries are required.
- A regularly running **cron** is needed for the time‑based log expiry to take
  effect (IP stripping works regardless of cron).

The module is covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/privacy_log -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/privacy_log -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en privacy_log -y
```

IP stripping is active immediately and needs no configuration. Optionally adjust the
retention window at **Configuration → Development → Logging and errors** — see
[How to use it](../index.md#how-to-use-it).

## Verify it worked

Trigger a log entry (for example by visiting a page that logs something) and check a
new `watchdog` entry — its IP field should be **empty**. Then set a short **Database
log messages expiry** on the Logging and errors form, run `drush cron`, and confirm
that log rows older than the window are removed.
