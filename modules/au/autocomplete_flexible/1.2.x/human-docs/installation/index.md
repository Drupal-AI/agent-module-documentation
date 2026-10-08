# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- No contrib module dependencies and no third-party Composer or PHP library
  requirements. It builds on core's entity-reference autocomplete.

## Install with Composer

From the project root:

```bash
composer require drupal/autocomplete_flexible -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/autocomplete_flexible -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en autocomplete_flexible -y
```

Once enabled, choose the **Autocomplete Flexible** widget on a field's **Manage
form display** screen, as described on the [overview page](../index.md). There is
no separate configuration screen.

## Optional: the examples submodule

The project bundles an optional **Autocomplete Flexible Examples**
(`autocomplete_flexible_examples`) submodule with a working demo controller,
form, and library. Enable it if you want a live reference for building your own
forms:

```bash
drush en autocomplete_flexible_examples -y
```

It requires the base Autocomplete Flexible module, which is already present once
you have installed it above. It is for learning/reference — you would not
normally leave it enabled on a production site.
