# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Node** module (`node`) and **Views** module (`views`) — both are
  dependencies and are on by default on a standard site; Drupal enables them
  automatically if needed.
- A working **cron** — the freshness scanner runs on cron, so make sure cron runs on
  a schedule for statuses to update automatically.

There are no third‑party PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_lifecycle -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_lifecycle -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_lifecycle -y
```

Drush will enable core Node and Views too if they are not already on.

## Verify it worked

Go to **Configuration → Content authoring → Entity Lifecycle**. You should see the
lifecycle settings where you enable per‑bundle scanning and define statuses and
conditions. Nothing is flagged until you enable scanning for at least one bundle and
cron runs — continue to [Configuration](../configuration/index.md).
