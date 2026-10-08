# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No third‑party Composer or PHP libraries.
- To use the workflow integration, core's **Workflows** and **Content
  Moderation** modules (enable the **Entity Version Workflows** submodule, which
  builds on them).

## Install with Composer

From the project root:

```bash
composer require drupal/entity_version -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_version -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_version -y
```

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Entity Version History** | `entity_version_history` | A view of the history of version numbers for a content item. |
| **Entity Version Workflows** | `entity_version_workflows` | Ties version numbers to core Workflows / Content Moderation, so each state transition can increase, decrease, or leave alone the major, minor, and patch numbers. |

Enable whichever you need, for example:

```bash
drush en entity_version_workflows -y
```

## Set up versioning on a content entity

After enabling, add a field of type **Entity version** to the content entity you
want versioned, from its **Manage fields** screen. If you enabled the Workflows
submodule, then configure your workflow's transitions with the desired increment
rules (see the main guide's "How to use it").

## Verify it worked

Add an **Entity version** field to a content type, create or edit a piece of that
content, and confirm the version number appears and behaves as expected — updating
manually, or according to your workflow transition rules if you enabled the
Workflows submodule.
