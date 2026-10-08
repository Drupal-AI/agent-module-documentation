# Installation

## Requirements

Metatag Webform is a small bridge between two other modules, so both must be
present:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Metatag** module (`metatag`) — it supplies the tag form and storage this
  module reuses.
- The **Webform** module (`webform`) — the forms you'll be adding meta tags to.

Both are declared as dependencies, so Drupal will refuse to enable Metatag
Webform until they are available. Composer pulls Metatag in automatically;
Webform you will usually already have (or add it the same way). There are no PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/metatag_webform -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including Metatag — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/metatag_webform -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en metatag_webform -y
```

This also enables Metatag and Webform if they are not already on. Once enabled,
open any webform's **Settings → Metatags** tab to start adding meta tags — see
[the index page](../index.md) for the step-by-step.

There are no submodules.
