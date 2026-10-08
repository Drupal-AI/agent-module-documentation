# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Nothing else — LiveFilter is pure JavaScript with **no external libraries** and
  no other module dependencies.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/livefilter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/livefilter -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en livefilter -y
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and confirm you can
place a **LiveFilter** block. Place one next to a list (the front‑page view is an
easy test — set **Elements selector** to `.views-row` and **Text XPath** to
`.//article`), save, and confirm that typing in the filter input narrows the list
instantly without reloading the page.
