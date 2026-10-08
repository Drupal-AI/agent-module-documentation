# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Monolog** module (`monolog`) — this is a hard dependency. Installing
  Monolog Extra with Composer pulls in Monolog (and the underlying
  `monolog/monolog` PHP library) automatically.

There are no additional third-party library requirements for this module.

## Install with Composer

From the project root:

```bash
composer require drupal/monolog_extra -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including the Monolog module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/monolog_extra -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en monolog_extra -y
```

Enabling the module makes its extra handlers and processors available as
services. It does **not** change any logging behaviour on its own — you still
have to reference the handlers/processors you want in your Monolog channel
configuration (see the Monolog module's README for how that file is laid out).

## Verify it worked

Confirm the module is enabled:

```bash
drush pm:list --status=enabled | grep monolog_extra
```

Then wire an extra handler or processor into your Monolog configuration and
trigger a log entry to confirm records are routed or enriched as you expect.
Remember to keep sensitive data out of the log context.
