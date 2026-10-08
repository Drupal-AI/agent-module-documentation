# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Views** (`views`) and **Content Moderation** (`content_moderation`)
  modules enabled. Drupal enables them automatically as dependencies when you turn on
  this module, but Content Moderation only does something once you have a workflow
  applied to a content type.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_cm_current_state -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/views_cm_current_state -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_cm_current_state -y
```

That's all. There is nothing to configure — the "Current state" field is now
available to add to any view. See [How to use it](../index.md#how-to-use-it) for the
steps.
