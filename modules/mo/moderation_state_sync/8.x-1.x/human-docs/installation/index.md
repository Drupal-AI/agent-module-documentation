# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core **Content Moderation** (`content_moderation`) enabled, with a workflow
  applied to your content.
- A **multilingual** setup with the moderation state made **translatable** for
  the bundles you want to keep in sync — this is what makes syncing meaningful.

Content Moderation is a Drupal core module and is enabled automatically as a
dependency. There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/moderation_state_sync -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/moderation_state_sync -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en moderation_state_sync -y
```

## Verify it worked

Go to **Configuration → Workflow → Workflows**
(`/admin/config/workflow/workflows`), edit a workflow, and open its **Workflow
settings**. For each state you should now see an **Enable moderation state sync**
option. Tick it for the states you want kept in sync, save, then change one
translation's state and confirm the other translations follow. See the
[main guide](../index.md) for the full setup.
