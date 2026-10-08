# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Node** module (`node`) — this is the only dependency, and it is part of
  the standard Drupal install, so it is almost always already enabled.

There are no third‑party Composer or PHP library requirements. Two things are
optional: enable core's **Search** module if you want the option to strip titles
from search results, and Display Suite if you use DS layouts (the module ships an
override so they honour its settings).

## Install with Composer

From the project root:

```bash
composer require drupal/exclude_node_title -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/exclude_node_title -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en exclude_node_title -y
```

## Grant permissions

At **People → Permissions** (`/admin/people/permissions`):

- **Administer exclude node title** — reach the settings form and configure which
  content types and view modes hide their titles. An administrative permission.
- **Exclude any node title** — on content types set to the per‑node mode, lets a
  user toggle the "Exclude title from display" checkbox on *any* node.
- **Exclude own node title** — the same checkbox, but only for nodes the user owns.

For example:

```bash
drush role:perm:add editor 'exclude own node title'
```

## Verify it worked

Visit **Configuration → Content authoring → Exclude Node Title** — the settings
form should load and list your content types. Set one to hide its title, view a
node of that type, and confirm the title no longer shows.
