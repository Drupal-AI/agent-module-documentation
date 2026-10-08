# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **Views** module (`views`) — a hard dependency, enabled automatically
  when you turn this module on.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/extrafield_views_integration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/extrafield_views_integration -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en extrafield_views_integration -y
```

There are no submodules. Once enabled, any `display` extra field that declares a
`render_class` key becomes available as a field in the Views UI — see
[How to use it](../index.md#how-to-use-it).
