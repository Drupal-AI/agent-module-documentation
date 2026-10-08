# Installation

## Requirements

- **Drupal 11.1 or 12** (`core_version_requirement: ^11.1 || ^12`).
- No dependencies beyond Drupal core, and no third‑party Composer or PHP
  libraries.

For messages to actually be written, PHP's own `error_log` ini directive must
point somewhere (the web server error log, stderr, or syslog) — that's standard
PHP configuration, not something you set in Drupal.

## Install with Composer

From the project root:

```bash
composer require drupal/error_log -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/error_log -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en error_log -y
```

There are no submodules. As soon as it's on, Drupal log messages begin going to
PHP's error log (all severities, no ignored channels — the defaults). Tune the
behavior on the **Logging and errors** page — see
[Configuration](../configuration/index.md).

> **On the command line:** under Drush, messages are dropped by default (Drush
> already logs to the console) unless PHP's `error_log` ini directive is set. Set
> that directive if you want CLI logging too.
