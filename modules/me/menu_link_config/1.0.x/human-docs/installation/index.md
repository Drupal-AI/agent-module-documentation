# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No module dependencies and no third‑party PHP or JavaScript libraries — it needs
  only Drupal core.

> **Heads up:** the current release is a long‑standing alpha
> (`8.x-1.0-alpha9`). Test it against your workflow before relying on it in
> production.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_link_config -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_link_config -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_link_config -y
```

Optionally, uninstall core's **Custom Menu Links** module afterward, since Menu
Link Config replaces it:

```bash
drush pmu custom_menu_links -y
```

## Verify it worked

Go to **Structure → Menus** (`/admin/structure/menu`) and open any menu. On its
management page you should now see an **Add config link** action next to the
standard *Add link*. Create a link with it, then confirm it appears in a
configuration export at **Configuration → Development → Configuration
synchronization → Export → Single item**.
