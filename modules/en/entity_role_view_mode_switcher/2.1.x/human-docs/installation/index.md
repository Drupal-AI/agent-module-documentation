# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No module dependencies, no third‑party Composer packages, and no PHP library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_role_view_mode_switcher -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_role_view_mode_switcher -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_role_view_mode_switcher -y
```

## Verify it worked

After enabling, define a View Mode Switcher Rule and add an entity reference field
that points at your rules, as described in the "How to use it" section of the
[overview](../index.md). Editing an entity should then let you select a rule, and
viewing that entity as different roles should render the display each role is meant
to see. Keep in mind this changes presentation only — not access.
