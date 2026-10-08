# Installation

## Requirements

Modal needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Filter** (`filter`) and **Datetime** (`datetime`) modules — used for the
  formatted modal body and for scheduling. Drupal enables them as dependencies when
  you turn the module on.

There are no third-party Composer or PHP library requirements. Bootstrap is optional:
the module can auto-load it (v3 or v5) from a CDN, or you can rely on your theme's
own Bootstrap — this is controlled on the global settings page after install.

## Install with Composer

From the project root:

```bash
composer require drupal/modal_page -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/modal_page -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en modal_page -y
```

## Grant the permission

The module defines one permission, **Administer Modal** (`administer modal page`),
which gates every admin page. Grant it to trusted administrators:

```bash
drush role:perm:add administrator 'administer modal page'
```

## Scheduling (optional)

If you plan to use the publish/unpublish scheduling on modals, arrange for the
scheduler to run — either via Drush from your server's crontab:

```bash
drush modal_page:cron
```

or by hitting the module's HTTP cron endpoint (`/modal-page/cron/{cron_key}`) when
you cannot run Drush. Without this, modals still work; only the timed
publish/unpublish will not fire.

Once enabled, head to [Configuration](../configuration/index.md) to create your
first modal.
