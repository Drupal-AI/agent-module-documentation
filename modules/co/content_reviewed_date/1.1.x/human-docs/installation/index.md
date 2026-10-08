# Installation

## Requirements

- **Drupal 11 or later** (`core_version_requirement: ^11`).
- Core's **Node** (`node`) and **DateTime** (`datetime`) modules — enabled
  automatically as dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/content_reviewed_date -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_reviewed_date -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_reviewed_date -y
```

## Verify it worked

Go to **Configuration → Content → Content Reviewed Date**
(`/admin/config/content/reviewed-date`). If the settings page loads and lists your
content types, the module is installed. Select at least one content type to track,
save, then open **Content → Stale Content** (`/admin/content/stale-review`) — the
report page should load. Continue to [Configuration](../configuration/index.md) to
finish setting thresholds and permissions.
