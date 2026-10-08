# Installation

## Requirements

- **Drupal 8, 9, 10, 11, or 12** (`core_version_requirement: ^8 || ^9 || ^10 ||
  ^11 || ^12`).
- Core's **Views** module enabled (it is what supplies the exposed filters Date
  Popup enhances).
- **Search API** (optional) — if it is installed, its `search_api_date` exposed
  filter also gains the HTML5 picker. It is not required.

There are no third‑party Composer or PHP library requirements, and no module
dependencies are declared.

## Install with Composer

From the project root:

```bash
composer require drupal/date_popup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/date_popup -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en date_popup -y
```

That is the entire setup. There is no configuration and no settings form — once
enabled, every exposed date filter on every View renders as an HTML5 calendar
picker automatically. There are no submodules.
