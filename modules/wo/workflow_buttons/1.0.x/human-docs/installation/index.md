# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Workflows** (`workflows`) and **Content Moderation**
  (`content_moderation`) modules — Drupal enables them as dependencies. You also
  need at least one moderation workflow set up, with your content types assigned
  to it, before the buttons have anything to show.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/workflow_buttons -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/workflow_buttons -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en workflow_buttons -y
```

Because the module registers `workflow_buttons` as the default widget for the
moderation‑state field, moderated content forms often switch to the button style
immediately. See [Configuration](../configuration/index.md) to confirm or change
this per content type.

## Optional submodule — Trash

Workflow buttons ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Workflow buttons Trash** | `workflow_buttons_trash` | A soft‑delete ("Trash") workflow that pairs with the buttons, giving editors a one‑click Trash action instead of a hard delete. |

Enable it only if you want the soft‑delete workflow:

```bash
drush en workflow_buttons_trash -y
```
