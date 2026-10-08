# Installation

## Requirements

- **Drupal 10.5 or 11** (`core_version_requirement: ^10.5 || ^11`).
- The **POTX** module (`drupal/potx`, Translation Template Extractor) — this is a
  hard dependency and provides the extraction engine PET drives.
- **Drush 13** to run the command.
- At least one translatable language configured on the site (so there is a target
  language to extract for).

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/drush_pet -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in POTX and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/drush_pet -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drush_pet -y
```

This also enables POTX if it isn't already on. Because PET exists purely to add a
developer Drush command, keep it enabled only on **development environments** —
there's no need for it on production.

## Verify it worked

Confirm Drush can see the command:

```bash
drush help pet
```

If the help text appears, PET is installed and ready to extract translations.
