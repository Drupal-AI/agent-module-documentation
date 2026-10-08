# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No external libraries and no other module dependencies — Logger works out of the
  box.

If you want to store logs in the database and browse them in the admin panel,
install the separate **Logger DB** module (`drupal/logger_db`) as well; Logger
integrates with it automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/logger -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/logger -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en logger -y
```

That's the entire install. Logger starts working immediately with its default
settings, writing JSON‑lines output to the temporary file
`temporary://drupal-log.jsonl`. For anything beyond a quick trial you'll want to
change that target — see [Configuration](../configuration/index.md).

## Verify it worked

Trigger any action that writes a log entry (or use the site normally for a
moment), then check the default target file `temporary://drupal-log.jsonl`. You
should see newly appended JSON‑lines records. Once you switch the target on the
settings page, verify the new destination instead (for example, that records
appear in stderr, syslog, or — with Logger DB — the admin log UI).
