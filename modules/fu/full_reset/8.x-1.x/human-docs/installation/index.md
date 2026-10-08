# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **System** module (always present) — the only dependency.
- **For Layout Builder blocks only:** the module currently requires a core patch
  from issue [#3015152](https://www.drupal.org/node/3015152). The field-level reset
  works without it.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/full_reset -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/full_reset -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

> **Applying the core patch (Layout Builder only):** if you need the reset on Layout
> Builder blocks, apply the patch from issue #3015152 to Drupal core, typically via
> `cweagans/composer-patches`. You can skip this if you only reset fields.

## Enable the module

```bash
drush en full_reset -y
```

## Verify it worked

Edit the display of a field (under a content type's **Manage display**) or a Layout
Builder block. You should see the new option to remove the wrapper markup. Enable it
and check the rendered output — the field or block should render without Drupal's
default wrapper elements and classes.
