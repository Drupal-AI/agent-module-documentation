# Installation

## Requirements

- **Drupal 10 or newer** (`core_version_requirement: >=10`).
- No module dependencies and no third‑party PHP or JavaScript libraries.
- To flag links through the UI you'll use core's **Menu Link Content**, which is
  part of a standard Drupal install.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_link_destination -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_link_destination -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_link_destination -y
```

## Verify it worked

Edit a menu link at **Structure → Menus → *(a menu)* → Edit link** and confirm the
new **Add a destination query parameter** checkbox appears. Tick it, save, and
inspect the rendered link on the front end — its `href` should include a
`destination=` query parameter.
