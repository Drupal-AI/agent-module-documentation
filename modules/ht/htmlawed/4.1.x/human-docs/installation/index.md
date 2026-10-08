# Installation

## Requirements

htmLawed bundles the htmLawed PHP library (version 1.2.15), so there is nothing
extra to download. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Filter** module (part of standard Drupal) — that is what text formats
  are built on.

There are no third‑party Composer or PHP library requirements. Optionally, the
contrib **Libraries** module can be used to load a newer external copy of
htmLawed instead of the bundled one, but that is not required.

## Install with Composer

From the project root:

```bash
composer require drupal/htmlawed -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/htmlawed -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en htmlawed -y
```

Enabling the module makes the **htmLawed** filter available, but it does not
change any text format until you turn the filter on for one. Continue to
[Configuration](../configuration/index.md) to apply it to a text format.
