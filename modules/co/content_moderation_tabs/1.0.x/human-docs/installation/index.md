# Installation

## Requirements

- **Drupal 11.1 or newer** (`core_version_requirement: ^11.1`).
- Core's **Content Moderation** module (`content_moderation`) enabled — this is
  the only dependency, and Drupal enables it (along with Workflows) automatically.

There are no third‑party Composer or PHP library requirements.

The **Workflow Buttons** and **Trash Workflows** modules are recommended
complements, and the *Editorial workflow for Drutopia* recipe will install both of
those plus this module and a ready-made editorial workflow.

## Install with Composer

From the project root:

```bash
composer require drupal/content_moderation_tabs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_moderation_tabs -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_moderation_tabs -y
```

## Verify it worked

Go to **Configuration → Workflow → Workflows**
(`/admin/config/workflow/workflows`) and edit a Content Moderation workflow
state. You should now see an **Enable tab** option (with fields for the tab name,
weight, and view route). Enable it on a state, save, then visit **Content**
(`/admin/content`) — your new tab should appear alongside the Overview tab. See
the main guide's [How to use it](../index.md#how-to-use-it) section for the full
walkthrough.
