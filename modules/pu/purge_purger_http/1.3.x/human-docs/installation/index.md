# Installation

## Requirements

Generic HTTP Purger needs:

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- **PHP 7.3 or newer** (`php: >=7.3`).
- The **Purge** framework (`drupal/purge` ^3.3) and the **Purge Tokens**
  (`purge_tokens`) module — both are declared dependencies, so Composer and Drupal
  bring them in for you.

There are no other third‑party Composer libraries or special PHP extensions to
install.

## Install with Composer

From the project root:

```bash
composer require drupal/purge_purger_http -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed and pulls in Purge and Purge Tokens.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/purge_purger_http -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en purge_purger_http -y
```

Drupal enables `purge` and `purge_tokens` at the same time as dependencies. Note
that enabling the module does not create any purgers — you add those through the
Purge UI (see [Configuration](../configuration/index.md)).

## Submodule — Generic HTTP Tags Header

Generic HTTP Purger ships one optional submodule, **Generic HTTP Tags Header**
(`purge_purger_http_tagsheader`). It emits a `Purge-Cache-Tags` response header so
a tag‑aware reverse proxy can do tag‑based invalidation. Enable it only if your
proxy reads that header:

```bash
drush en purge_purger_http_tagsheader -y
```

## Verify it worked

Go to **Configuration → Development → Performance → Purge**
(`/admin/config/development/performance/purge`). Click **Add purger** and confirm
**HTTP purger** and **Bundled HTTP purger** appear as options. See
[Configuration](../configuration/index.md) for the full setup.
