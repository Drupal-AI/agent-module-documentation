# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core modules **Comment** (`comment`), **Datetime** (`datetime`), **Options**
  (`options`), **Text** (`text`), and **Views** (`views`) — all enabled
  automatically as dependencies.

There are no third‑party Composer or PHP library requirements. (This is a beta
release: `2.0.0-beta3`.)

## Install with Composer

From the project root:

```bash
composer require drupal/community_tasks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/community_tasks -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en community_tasks -y
```

Enabling it also enables the core dependencies and creates the task content type.

## Verify it worked

Confirm the task content type now appears under **Structure → Content types**,
then grant the relevant permissions under **People → Permissions** and start
posting tasks. See the [overview](../index.md) for how the volunteer workflow and
Views integration fit together.
