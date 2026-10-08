# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Project Browser** module (`project_browser`) — this module is a source
  plugin *for* Project Browser and cannot work without it. Composer pulls it in
  automatically with the command below.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/project_browser_gitlab -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Project Browser
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/project_browser_gitlab -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en project_browser_gitlab -y
```

Drupal enables **Project Browser** at the same time if it isn't already on.

## Verify it worked

Visit **Configuration → Development → Project Browser Gitlab**
(`/admin/config/development/project_browser_gitlab`). You should reach the form
for defining a GitLab source. Continue to [Configuration](../configuration/index.md)
to set it up and turn it on.
