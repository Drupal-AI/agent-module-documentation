# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Core's **Menu UI** module (`menu_ui`) — Drupal enables it automatically as a
  dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_ui_async_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_ui_async_widget -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_ui_async_widget -y
```

That's all — there is no configuration. The asynchronous widget replaces the
standard menu widget on node forms immediately.

## Verify it worked

Edit any node. In place of the usual "Provide a menu link" section you should now
see a button that, when clicked, loads the menu selection UI over AJAX. The clearest
benefit appears on sites with very large menus, where the node form now opens
noticeably faster.
