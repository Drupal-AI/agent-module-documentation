# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Workflows** module (`workflows`) enabled — this is the only declared
  dependency.
- In practice you'll also want core's **Content Moderation** module enabled and a
  workflow configured, since this module only acts on entities that Content
  Moderation treats as moderated. Without a moderation workflow there are no
  states to generate permissions from.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/moderation_state_permissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/moderation_state_permissions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en moderation_state_permissions -y
```

Once enabled, the per‑state permissions appear automatically on the permissions
page for whatever workflows and states you have configured. Head to
[Configuration](../configuration/index.md) to grant them.
