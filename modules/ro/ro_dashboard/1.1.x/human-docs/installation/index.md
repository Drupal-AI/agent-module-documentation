# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core **Views**, which the dashboard uses to present its lists — this is the only
  hard requirement for the module itself.
- To actually collect data from your other sites, each monitored site needs the
  **[Site Guardian](https://www.drupal.org/project/site_guardian)** module
  installed and generating reports.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ro_dashboard -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ro_dashboard -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ro_dashboard -y
```

## Verify it worked

Log in as an administrator. You should be able to reach the RO Dashboard and its
screen for adding **Site entities**. Grant the module's permissions to your trusted
operators (at **People → Permissions**, `/admin/people/permissions`), then follow
the [Configuration](../configuration/index.md) guide to add your first monitored
site.
