# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Node** module (`node`) — the only dependency.

There are no third‑party Composer packages or PHP library requirements, and no
configuration is needed.

## Install with Composer

From the project root:

```bash
composer require drupal/node_co_authors -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_co_authors -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_co_authors -y
```

The `co_authors` field is added to nodes automatically on enable.

## Verify it worked

Edit any node and look in the sidebar (after the author field) for a **Co-authors**
field. Then visit **People → Permissions** and confirm the three co-author
permissions are present, and grant them to the appropriate roles. See the
[overview](../index.md) for how those permissions and the field work together.
