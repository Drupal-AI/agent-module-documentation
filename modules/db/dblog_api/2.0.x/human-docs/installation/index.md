# Installation

## Requirements

- **Drupal 10.2, 11, or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- Core's **Database Logging** module (`dblog`) — the only dependency. Drupal
  enables it automatically as a dependency when you turn on Database logging API.

There are no third‑party Composer or PHP library requirements, and it needs no
external service.

## Install with Composer

From the project root:

```bash
composer require drupal/dblog_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dblog_api -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dblog_api -y
```

Enabling it also enables core's `dblog` module if it isn't already on. In many
cases you won't run this command yourself — a module that depends on `dblog_api`
will pull it in when you install it.

## Verify it worked

On its own, `dblog_api` adds no visible change to the log report — it only makes
the operation plugin type available. To confirm it works, enable a module that
*provides* a dblog operation (such as an IP-ban operation) and check that the new
action link appears on **Reports → Recent log messages**.
