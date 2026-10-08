# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- No other contrib modules are required.

There are no PHP library or Composer requirements beyond Drupal core. One optional
extra exists: Google's `data-layer-helper` JavaScript library. If you want to use
it (it lets custom scripts read the dataLayer as a state object), download it and
place it at `/libraries/data-layer-helper/dist/data-layer-helper.js`, then enable
the corresponding option on the settings form. It is entirely optional — the
module works without it.

## Install with Composer

From the project root:

```bash
composer require drupal/datalayer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/datalayer -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en datalayer -y
```

The module ships no submodules. Once enabled it starts emitting the dataLayer on
non-admin pages using its defaults; head to
[Configuration](../configuration/index.md) to tailor what it outputs.
