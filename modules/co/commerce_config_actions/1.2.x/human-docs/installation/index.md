# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- **Commerce Price** (`commerce_price`) enabled — it ships with Drupal Commerce.

There are no third‑party Composer or PHP library requirements. Note the module is
**experimental**, so pin the version you deploy and test before relying on it in
production.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_config_actions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in or update any
shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/commerce_config_actions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_config_actions -y
```

In practice this module is usually enabled *by* a recipe that needs its config
actions, rather than turned on by hand — but the command above works if you want
it available directly.

## Verify it worked

There is no settings page to check. Confirm the module is enabled with
`drush pm:list --status=enabled | grep commerce_config_actions` (or under
**Extend** in the admin UI). The config actions it provides then become available
to any Commerce recipe you apply.
