# Installation

## Requirements

Group Content Menu needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`; the Composer
  constraint is `^10.3 || >=11.1.7 <11.2 || ^11.2`).
- The **Group** module (`drupal/group`, `^3.0@beta`) — the contrib module this one
  extends. Composer installs it for you.
- Core's **Block** (`block`), **Menu Link Content** (`menu_link_content`) and
  **Menu UI** (`menu_ui`) modules, which Drupal enables as dependencies.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/group_content_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Group module (if
it is not already present) and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/group_content_menu -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_content_menu -y
```

This also enables Group and the required core modules if they are not already on.

## Grant permissions

The module defines one **global** permission and three **per-group** permissions.
Grant the global one to trusted site admins so they can define menu types:

```bash
drush role:perm:add administrator 'administer group content menu types'
```

The three per-group permissions (*access group content menu overview*,
*manage group content menu*, *manage group content menu menu items*) are assigned to
**group roles** through the Group module's permission UI, not the site-wide roles
page. See [Configuration → Permissions](../configuration/index.md#permissions) for
what each one allows.

Once enabled, continue to [Configuration](../configuration/index.md) to define your
first menu type.
