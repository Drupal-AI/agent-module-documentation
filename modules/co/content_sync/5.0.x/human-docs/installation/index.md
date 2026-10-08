# Installation

## Requirements

- **Drupal 10.1 or 11** per the module's `info.yml` — but see the compatibility
  warning below.
- Core's **Serialization** module (`serialization`) — the only dependency, and Drupal
  enables it automatically.

There are no third-party libraries.

> **Compatibility warning — check your Drupal version first.** This `5.0.x` branch
> resolves to the `dev-5.0.x` development branch, and it is **verified broken on Drupal
> 11.4+**. Once enabled there, the container fails to build and every `drush` command
> and web request fatals — and because the failure happens during bootstrap, you can't
> uninstall it with Drush (recovery means removing `content_sync` from the
> `core.extension` config directly in the database and clearing caches). Only install
> it on **Drupal 10.1–11.3** until the upstream fix lands.

## Install with Composer

From the project root:

```bash
composer require drupal/content_sync -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_sync -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_sync -y
```

Enabling the module creates two database tables it uses internally: `cs_db_snapshot`
(the last-known content state, used to build the change list) and `cs_logs` (its own
log).

## After enabling

Before you can export or import anything, you must declare a **content sync
directory** in `settings.php` — there is no admin field for it. That step, the
settings form, and the export/import workflow are covered in
[Configuration](../configuration/index.md).
