# Installation

## Requirements

Language Icons is a small multilingual helper. It needs:

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Core's **Locale** module (`locale`) enabled — this is the only dependency, and
  Drupal enables it automatically as a dependency.
- At least **two configured languages** and a visible **Language switcher** block,
  otherwise there are no language links for the icons to attach to.

There are no third‑party Composer or PHP library requirements; the flag images ship
with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/languageicons -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/languageicons -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en languageicons -y
```

On install the module sets its icon path to its own bundled `flags/*.png` set, so
flags will show up as soon as there are language links on the page.

## Verify it worked

Place the core **Language switcher** block (**Structure → Block layout**, under the
"Interface text language selection" language type) in a visible region, then load a
page. Each language link should now carry a small flag. To change how those flags
look, see [Configuration](../configuration/index.md).
