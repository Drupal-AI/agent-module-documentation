# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: >=9`, Composer
  `drupal/core: ^9.5 || ^10 || ^11`).
- Core's **Node** (`node`) and **Comment** (`comment`) modules — dependencies that
  Drupal enables for you.
- Optionally, core's **History** module — when it's enabled, authenticated users
  get read/unread markers on the activity lists.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/tracker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tracker -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

> **Note:** In older Drupal versions Tracker was part of core. On a modern site it
> is this separate contrib project — install it with the command above.

## Enable the module

```bash
drush en tracker -y
```

Drupal enables Node and Comment as dependencies at the same time.

## After enabling

- The **/activity** page works right away for users with the **Access content**
  permission.
- On a site that already has content, the module needs to build its index of
  existing nodes. It does this in the background over one or more **cron** runs —
  see [Configuration](../configuration/index.md) for the batch‑size setting. New
  and edited content is indexed immediately, regardless of cron.

## Verify it worked

Visit **/activity**. You should see a table of recent content (it fills in for
older content as cron runs). Each user profile also gains an **Activity** tab.
