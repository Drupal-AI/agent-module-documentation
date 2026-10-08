# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No dependencies beyond Drupal core, and no third-party Composer or PHP
  libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/no_translation_on_admin_pages -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/no_translation_on_admin_pages -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en no_translation_on_admin_pages -y
```

## Clear caches

The module works through a preprocess hook, so **clear caches after enabling** so
the change takes effect:

```bash
drush cr
```

## Verify it worked

Open any admin page and view its page source. The `<body>` element should carry
the `notranslate` class and a `translate="no"` attribute. In a Chromium-based
browser with translation enabled, the admin UI should no longer be offered for
automatic translation.
