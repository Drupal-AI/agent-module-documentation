# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.2** or newer.
- **Advanced Mautic Integration** (`advanced_mautic_integration`) version ^1.0 —
  this provides the Mautic API client and the tracking script that identifies
  visitors. Mautic Audiences is the render‑time consumer that sits on top of it.

## Install with Composer

From the project root:

```bash
composer require drupal/mautic_audiences -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Advanced Mautic
Integration and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mautic_audiences -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mautic_audiences -y
```

If you use the [Klaro](https://www.drupal.org/project/klaro) consent manager and
want consent‑gated resolution, also enable the optional sub‑module:

```bash
drush en mautic_audiences_klaro -y
```

## Verify it worked

Visit **Configuration → Web services → Mautic Audiences**
(`/admin/config/services/mautic-audiences`) to complete setup — at minimum, **set a
webhook secret** (see [Configuration](../configuration/index.md)). Then check the
editorial debug page at **Reports → Mautic Audiences**
(`/admin/reports/mautic-audiences`): it shows a snapshot of what the resolver sees
for the current viewer, which is the quickest confirmation the module is wired up.
