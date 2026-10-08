# Installation

## Requirements

JSON Log needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Nothing else — it has no module dependencies and no third‑party PHP libraries.

For file output, the web server user must be able to write to the chosen log
directory (see [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/jsonlog -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonlog -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonlog -y
```

Once enabled, the logger starts capturing events using its defaults (log to a file
under a directory derived from PHP's `error_log` path, warning‑and‑above severity,
daily file rotation). To point it at the right directory or switch to STDOUT, head
to [Configuration](../configuration/index.md).
