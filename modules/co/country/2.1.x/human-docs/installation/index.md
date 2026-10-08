# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** (`field`) module, which Drupal enables as a dependency.
- **Recommended:** PHP's `intl` extension (`ext-intl`). It is not required, but
  it improves the sorting of country names in non‑English languages.

There are no other Composer package requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/country -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/country -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en country -y
```

That is all the setup there is — the module has no configuration form and no
permissions. Once enabled, **Country** appears as an option when you add a field
to any entity bundle. See the [overview](../index.md#how-to-use-it) for adding
and configuring a country field.
