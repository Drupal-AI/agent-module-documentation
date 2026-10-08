# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **Admin Toolbar** module (`admin_toolbar`) — this is the module's only
  dependency, and the toolbar it manages is where the custom logo appears.
  Composer installs it for you.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/druplicon -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Admin Toolbar
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/druplicon -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en druplicon -y
```

Drupal enables Admin Toolbar automatically as a dependency if it is not already
on. To actually see the swapped logo in the toolbar, you will typically want
Admin Toolbar's **Extra Tools** submodule (`admin_toolbar_tools`) enabled too,
since that is what shows the Druplicon logo in the first place.

## Verify it worked

Once enabled, go to **Configuration → User interface → Druplicon**
(`/admin/config/druplicon/settings`). If the settings form with its image upload
field loads, the module is installed. Upload an image and save — see
[Configuration](../configuration/index.md) — then reload any admin page (clearing
caches if needed) to see your logo in the toolbar.
