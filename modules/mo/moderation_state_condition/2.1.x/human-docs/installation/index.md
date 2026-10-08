# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core **Workflows** (`workflows`) and **Content Moderation**
  (`content_moderation`) enabled, with a workflow applied to your content.

Both dependencies are Drupal core modules and are enabled automatically as
dependencies when you turn on this module. There are no third‑party Composer or
PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/moderation_state_condition -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/moderation_state_condition -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en moderation_state_condition -y
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`), place or configure
a block, and open its **Visibility** settings. You should see a **moderation
state** condition you can configure. See the [main guide](../index.md) for how to
apply it.
