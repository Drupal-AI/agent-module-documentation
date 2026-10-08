# Installation

## Requirements

Menu Trail By Path needs **Drupal 9, 10, or 11** (`core_version_requirement:
^9 || ^10 || ^11`). It has **no other module dependencies** and pulls in no extra
libraries, so there is nothing else to install alongside it.

Optional but recommended:

- **Pathauto** (`pathauto`) — not required, but a natural companion. Pathauto gives
  your nodes path-structured URL aliases (for example `/about/team`), and Menu
  Trail By Path follows exactly that structure when deciding which menu item to
  highlight. With both installed, your aliases drive the menu trail automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_trail_by_path -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/menu_trail_by_path -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_trail_by_path -y
```

Once enabled, the module quietly replaces core's active-trail service with its own
path-aware version, so any menu block or breadcrumb that relies on the active trail
starts respecting the URL hierarchy immediately.

## Verify it worked

Log in as an administrator and go to
`/admin/config/system/menu_trail_by_path/settings`. You should see the **Menu Trail
By Path Settings** page with a **Maximum path parts** field, a **Trail Source**
choice, and a **Save configuration** button:

![The Menu Trail By Path Settings page](../images/settings.png)

If the page loads with those controls, the module is installed correctly. Next,
review the [configuration options](../configuration/index.md) to choose how the
trail is derived.
