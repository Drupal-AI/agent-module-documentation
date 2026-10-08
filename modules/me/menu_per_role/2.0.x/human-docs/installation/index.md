# Installation

## Requirements

- **Drupal 11.2 or 12** (`core_version_requirement: ^11.2 || ^12`).
- Core's **Menu Link Content** module (`menu_link_content`), enabled automatically
  as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_per_role -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/menu_per_role -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_per_role -y
```

The module ships **no submodules**.

## Set permissions

Two permissions are relevant. Go to **People → Permissions** and grant:

- **Administer Menu Per Role settings** — for the roles that should manage the
  module's global settings form.
- **Assign menu role visibility** (the per-link `assign menu role visibility`
  permission) — this is the important one: **without it, the per-role fields are
  hidden on the menu-link edit form**, so an editor can manage the link but not
  its role visibility. Grant it to the roles that should be able to set which
  roles see which links.

## Verify it worked

Edit any content menu link (for example under **Structure → Menus → Main
navigation**). If you hold the "Assign menu role visibility" permission, you
should see one or two new fieldsets of role checkboxes on the link's edit form.
See [Configuration](../configuration/index.md) for how those fields behave and how
the global settings control which of them appear.
