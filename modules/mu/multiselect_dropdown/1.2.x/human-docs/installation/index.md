# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1 or newer** (`php: ^8.1`).

No other modules are required for the base module. The Views exposed-filter
submodule additionally needs **Better Exposed Filters** (`drupal/better_exposed_filters`,
`^6 || ^7`), which is only a *suggested* dependency — install it if you plan to
use that submodule.

## Install with Composer

From the project root:

```bash
composer require drupal/multiselect_dropdown -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/multiselect_dropdown -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en multiselect_dropdown -y
```

The widget is now available on *Manage form display* for eligible fields — see the
[overview](../index.md) for how to select and configure it.

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Better Exposed Filters integration** | `multiselect_dropdown_bef` | A Better Exposed Filters widget so the dropdown can be used as a **Views exposed filter**. Requires the Better Exposed Filters module. |
| **Dialog polyfill** | `multiselect_dropdown_polyfill` | Loads the GoogleChrome `dialog-polyfill` so the native `<dialog>` works in older browsers (roughly pre-2019). Enable it only if you must support those browsers. |

Enable a submodule with `drush en`, for example:

```bash
drush en multiselect_dropdown_bef -y
```

Each submodule requires the base Multiselect Dropdown module, which is already
present once you've installed it above.
