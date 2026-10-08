# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10.0 || ^11`).
- Core's **Field** module (`field`) enabled — this is part of core and almost
  always already on.

There are no third-party Composer or PHP library requirements. Note that the
indicator only works with the two supported core text widgets — **Textfield**
(`string_textfield`) and **Text area (multiple rows)** (`string_textarea`) — so
you'll want at least one field using one of those.

## Install with Composer

From the project root:

```bash
composer require drupal/length_indicator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/length_indicator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en length_indicator -y
```

That's all it takes to install. Nothing changes on any form yet — you turn the
indicator on per field. No submodules ship with this project.

## Next step

Head to [Configuration](../configuration/index.md) to enable the indicator on a
field and set its target length range.
