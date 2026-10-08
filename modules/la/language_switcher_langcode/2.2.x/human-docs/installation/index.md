# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Language** module (`language`), enabled — the only dependency, and
  Drupal enables it automatically.

There are no third-party Composer or PHP library requirements. To actually *see*
the effect you'll want at least two configured languages and the core **Language
switcher** block placed in a region.

## Install with Composer

From the project root:

```bash
composer require drupal/language_switcher_langcode -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/language_switcher_langcode -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en language_switcher_langcode -y
```

Core Language is pulled in automatically if it isn't already on. There's nothing to
configure — the module starts rewriting language-switch links immediately.

## Verify it worked

With at least two languages configured and the core **Language switcher** block
placed (via **Structure → Block layout**), load the site: the switcher should show
uppercase language codes (EN, FR, DE …) with the full name on hover. You can also
confirm it from the command line using the `drush php:eval` snippet in the
[overview](../index.md#how-to-use-it).
