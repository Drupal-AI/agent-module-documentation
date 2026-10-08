# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **PHP 8.1.0 or newer** (`php: ^8.1.0`) — this is the Monolog 3.x branch.
- The **Monolog** PHP library (`monolog/monolog` `^3.2.0`), installed
  automatically with Composer (see below).

There are no Drupal module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/monolog -W
```

This installs both the module **and** the `monolog/monolog` library — Composer is
the only supported way to bring in the library. The `-W`
(`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/monolog -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en monolog -y
```

The module ships **no submodules**.

## Configure it (required to be useful)

Enabling Monolog is not enough on its own — and note that it **takes over Drupal's
logging**, so until you configure handlers you should set up at least a default
handler (and re-add the database log if you still want it). Configuration is done
in a services YAML file registered in `settings.php`; see
[the main guide](../index.md#how-to-configure-it) for the steps.

## Verify it worked

After enabling and configuring a handler, trigger a log entry (for example run
`drush cr`, then check your configured destination — a rotating file, syslog, or
stdout). If you kept the `drupal.dblog` handler, entries will also appear at
**Reports → Recent log messages** (`/admin/reports/dblog`). If you did *not*
re-add it, the database log will be empty — that's expected, because Monolog is
now routing logs where you told it to.
