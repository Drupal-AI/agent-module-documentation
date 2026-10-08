# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other modules, PHP libraries, or third-party Composer packages — the module
  depends only on Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/form_options_attributes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/form_options_attributes -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en form_options_attributes -y
```

That's the whole setup. There is no configuration form — once enabled, the
`#options_attributes` property (and the wrapper/label variants for radios and
checkboxes) is available to use in your form code. See the
[overview](../index.md) for a usage example.
