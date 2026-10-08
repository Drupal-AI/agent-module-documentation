# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field** module (`field`), which is enabled on virtually every Drupal
  site already and is pulled in automatically as a dependency.

The Select2 JavaScript library itself is loaded from a CDN at runtime (configurable
on the settings form), so there is nothing extra to download. Two optional
integrations light up only if you also have those modules: the **Flags** module
(for flag icons on language/country selects) and the **Address** module (for
Select2 on country/zone selects).

## Install with Composer

From the project root:

```bash
composer require drupal/select2boxes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/select2boxes -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en select2boxes -y
```

Then either switch individual fields to a Select2 widget on their *Manage form
display*, or turn on global mode at *Configuration → User interface → Select2
Boxes* — see the [main guide](../index.md#how-to-use-it).

## Optional submodule — Select2 for Better Exposed Filters

If you use Views with the Better Exposed Filters module and want your exposed
filters to use Select2 as well, enable the bundled submodule:

```bash
drush en select2_bef -y
```

It requires the base Select2 Boxes module (already present once you've installed
the above) and, of course, Better Exposed Filters.
