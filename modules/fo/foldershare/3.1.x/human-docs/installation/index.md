# Installation

## Requirements

FolderShare needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.2** or newer.
- A **MySQL/MariaDB or SQLite** database. FolderShare does **not** work with
  PostgreSQL.
- A **top-level domain or subdomain** — sites configured to run in a subfolder do
  not work well with FolderShare.
- Several core modules, which Drupal enables automatically as dependencies:
  `datetime`, `field`, `file`, `filter`, `image`, `link`, `media`, `options`,
  `system`, `text`, `user`, and `views`, plus `jquery_ui_button` and
  `jquery_ui_menu`.

Before rolling it out, read the module's own help page carefully at
**Help → FolderShare** (`/admin/help/foldershare`).

## Install with Composer

From the project root:

```bash
composer require drupal/foldershare -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the jQuery UI
modules and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/foldershare -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en foldershare -y
```

## Companion modules

FolderShare works with optional companion modules you can add later:

- **FolderShare REST** — adds a REST interface and a command-line client for
  managing data programmatically.
- **Chart Suite** and **Formatter Suite** — provide richer displays and
  formatters for FolderShare content.

Install these only if you need them.

## Verify it worked

1. Set up the [permissions and minimal settings](../configuration/index.md).
2. As a user who holds the FolderShare permissions, visit **`/foldershare`** — you
   should see your (empty) file browser.
3. Create a folder and upload a file to confirm storage is working.

> **Set up cron.** FolderShare queues long-running tasks (to avoid PHP execution
> limits) and runs them on cron. Run cron frequently from an **external** source
> rather than relying on Drupal core's automated cron.
