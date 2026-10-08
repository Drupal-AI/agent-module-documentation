# Installation

## Requirements

- **Drupal 10.5 or 11** (`core_version_requirement: ^10.5||^11`).
- Core's **Locale** module (`locale`).
- **Drush 10+** for the push/pull commands.
- The **Loco PHP SDK** (`loco/loco`), an external library the module uses to talk
  to the Loco API — installed via Composer alongside the module.
- A **Loco account** at [localise.biz](https://localise.biz) with API keys for your
  project.

## Install with Composer

From the project root:

```bash
composer require drupal/loco_translate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Loco PHP SDK
and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/loco_translate -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en loco_translate -y
```

## Verify it worked

After enabling, add your Loco API keys (see
[Configuration](../configuration/index.md)) and run a pull for a language you have
translations for, e.g.:

```bash
drush loco:pull fr
```

If the keys are correct, translations are fetched from Loco into Drupal. You can
also open the module's dashboard to see your Loco translation progress.
