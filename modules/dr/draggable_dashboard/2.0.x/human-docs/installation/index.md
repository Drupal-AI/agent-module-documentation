# Installation

## Requirements

- **Drupal 9.2+, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Core's **Block** module (`block`) — enabled in a standard install; the module
  builds dashboards out of block plugins and places them via Block layout.

There are no third-party PHP library requirements, no Drush commands, and no
submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/draggable_dashboard -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/draggable_dashboard -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en draggable_dashboard -y
```

## Grant the permission

The module adds one permission, **administer_draggable_dashboard**, which controls
all dashboard administration (creating, editing, and deleting dashboards and the
blocks within them). Grant it at **People → Permissions**
(`/admin/people/permissions`) to trusted roles only — see
[Configuration](../configuration/index.md) for why. Placing a finished dashboard on
the site additionally needs core's **Administer blocks** permission.

## Verify it worked

Go to **Structure → Draggable Dashboard**
(`/admin/structure/draggable-dashboard`). You should see a (initially empty) list
of dashboards with an **Add Dashboard** button. Continue to
[Configuration](../configuration/index.md) to build your first one.
