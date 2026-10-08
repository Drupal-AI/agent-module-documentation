# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1** or higher.
- Core's **System** module (always present).
- No third‑party contributed modules or external libraries — the interface is built
  with vanilla JavaScript, so there is no jQuery dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/module_matrix -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/module_matrix -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en module_matrix -y
```

## Verify it worked

Go to **Extend** (`/admin/modules`). Instead of the default table you should now see
the Module Matrix interface — a search box, status/lifecycle/stability filters, and
package groups with coloured counts. The **Uninstall** tab is enhanced the same way.
Then visit the Module Matrix settings form to tailor the layout, theme, and detail
fields (see "How to use it" in the [overview](../index.md)).
