# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Content Moderation** module (`content_moderation`) — its only dependency,
  stable since Drupal 8.5 — with a workflow applied to the content you want to show
  moderation info for.

Drupal will enable Content Moderation automatically as a dependency. There are no
third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/content_moderation_info_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_moderation_info_block -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_moderation_info_block -y
```

## Place the block

The block does nothing until you place it. Go to **Structure → Block layout**
(`/admin/structure/block`), click **Place block** in your chosen region, and add the
**Content Moderation Info** block. In its configuration, choose which details to
display and set any visibility conditions, then save. See the
[overview](../index.md) for the full list of options.

## Verify it worked

View a moderated content item as a user with moderation permissions. The block
should appear in the region you placed it, showing the moderation details you
enabled — and, if you turned on the state-change form, letting you move the content
to a new state with a revision log message.
