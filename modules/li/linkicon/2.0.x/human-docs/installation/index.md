# Installation

## Requirements

- **Drupal 8.8 or newer**, including 9, 10, and 11 (`core_version_requirement:
  >=8.8`).
- Core's **Link** module (`link`) enabled — this is the only dependency, and
  Drupal enables it automatically when you turn on this module. You also need a
  **Link field** somewhere to apply Link Icon to.
- An **icon font** to supply the actual glyphs. Link Icon only emits CSS classes;
  it does not ship icons. Load an icon font in your theme, or point the module's
  settings form at an icon-font CSS file (see Configuration).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/linkicon -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/linkicon -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en linkicon -y
```

Enabling the module does nothing visible on its own — you have to configure a link
field to use predefined titles and the Link icon formatter. Continue to
[Configuration](../configuration/index.md).
