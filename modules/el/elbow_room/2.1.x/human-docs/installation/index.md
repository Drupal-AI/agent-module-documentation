# Installation

## Requirements

- **Drupal 9.4 or 10** (`core_version_requirement: ^9.4 || ^10`).
- No other modules — Elbow room has no runtime dependencies beyond Drupal core.
- No third-party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/elbow_room -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/elbow_room -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en elbow_room -y
```

## Verify it worked

After enabling, grant the **Administer elbow room settings** permission to the roles
that should manage it, then open a node add or edit form (for example
`/node/add/article`). You should see the sidebar toggle that collapses and expands
the advanced column. See [Configuration](../configuration/index.md) for the
permission and options.
