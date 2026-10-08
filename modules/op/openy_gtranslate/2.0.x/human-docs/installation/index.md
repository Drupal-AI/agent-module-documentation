# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No module dependencies, and no permissions or configuration of its own.
- Packaged for the [Open Y / YMCA Website Services](https://www.drupal.org/project/openy)
  distribution, but it runs on any Drupal site.

## Install with Composer

From the project root:

```bash
composer require drupal/openy_gtranslate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/openy_gtranslate -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en openy_gtranslate -y
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and confirm the
**Open Y Google Translate** block is available to place. Place it in a region, view
a front-end page, and confirm the Google Translate widget appears and offers a
language selection.

> **Privacy reminder:** the widget loads a script from Google and sends page
> content there. On an EU-facing site, document it in your privacy notice and gate
> it behind cookie consent.
