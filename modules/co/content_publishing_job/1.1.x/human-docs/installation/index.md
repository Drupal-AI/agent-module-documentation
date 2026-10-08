# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **Block** module (`block`) — enabled automatically as a dependency.
- A working **cron** — the unpublishing runs on cron, so if cron never fires,
  nothing expires. Drupal's built-in cron is fine; a real system cron is
  recommended for production.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/content_publishing_job -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_publishing_job -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_publishing_job -y
```

## Verify it worked

Go to **Configuration → System → Publishing config**
(`/admin/config/system/publishing-config`). If the publishing jobs collection page
loads, the module is installed. Continue to
[Configuration](../configuration/index.md) to create your first unpublish job. To
test the whole flow end-to-end, create a job, give a test node a past expiry date,
run cron (`drush cron`), and confirm the node becomes unpublished.
