# Installation

## Requirements

- **Drupal 8.7.7+, 9, or 10** (`core_version_requirement: ^8.7.7 || ^9.0 || ^10`).
- Core's **Node** (`node`) and **Content Moderation** (`content_moderation`)
  modules — both are required and enabled automatically as dependencies.
- A **working cron** on your site, so the scheduled pruning actually runs.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cm_revision_delete -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cm_revision_delete -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cm_revision_delete -y
```

Content Moderation is enabled automatically if it isn't already.

## Verify it worked

Go to **Configuration → Content authoring → Content Moderation Revision Delete**
(`/admin/config/content/cm_revision_delete`) and confirm the settings form loads.
Nothing is pruned until you set a retention policy — continue to
[Configuration](../configuration/index.md).

> **Before your first run on a busy site:** back up the database and test your
> retention settings on a staging copy. The first prune on a site with deep revision
> history can delete a large number of revisions at once.
