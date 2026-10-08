# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **PHP 8.1** or newer.
- The **TMGMT** module (`tmgmt`) — the Translation Management Tool that provides
  the job/basket/checkout workflow.
- The **Ultimate Cron** module (`ultimate_cron`) — used to process translation
  jobs.
- **LanguageWire account credentials** (API access) — you obtain these from
  LanguageWire.

## Install with Composer

From the project root:

```bash
composer require drupal/languagewire_translation_provider -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in TMGMT, Ultimate
Cron, and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/languagewire_translation_provider -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en languagewire_translation_provider -y
```

Drupal will enable **TMGMT** and **Ultimate Cron** as dependencies if they are not
already on.

## Verify it worked

Confirm the module is enabled on the **Extend** page (`/admin/modules`), then open
**Translation → Providers** (`/admin/tmgmt/translators`) and start creating a new
provider — **LanguageWire** should be available as a translator plugin type. From
there, continue with [Configuration](../configuration/index.md).
