# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core **Content Moderation** (`content_moderation`) enabled, with at least one
  workflow applied to the entities you want to display.
- Core **Views** (`views`) enabled.

Both dependencies are Drupal core modules and will be enabled automatically as
dependencies when you turn on Moderation state columns. There are no third‑party
Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/moderation_state_columns -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/moderation_state_columns -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en moderation_state_columns -y
```

## Verify it worked

Go to **Structure → Views** (`/admin/structure/views`), edit or create a View of
moderated content, and open the display **Format** setting. You should see
**Moderation state columns** as an available format. Select it, choose a workflow
and states, save, and confirm the View renders as a column-per-state board. See
the [main guide](../index.md) for the full setup steps.
