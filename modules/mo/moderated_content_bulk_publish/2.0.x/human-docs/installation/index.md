# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Content Moderation** (`content_moderation`) and **Workflows**
  (`workflows`) modules — the module operates on content running a moderation
  workflow, so you should have an editorial workflow configured.
- **[Views Bulk Operations](https://www.drupal.org/project/views_bulk_operations)**
  (`drupal/views_bulk_operations`, ^4.0) — provides the bulk‑selection machinery on
  the content view.
- **[Pathauto](https://www.drupal.org/project/pathauto)** (`drupal/pathauto`) — a
  declared dependency of the project.

Drupal enables the required modules automatically as dependencies when you turn this
module on; the two contrib dependencies are pulled in by Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/moderated_content_bulk_publish -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in Views Bulk Operations and Pathauto.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/moderated_content_bulk_publish -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en moderated_content_bulk_publish -y
```

The bulk moderation actions are shipped as *optional* configuration, so they install
automatically once their dependencies (Content Moderation, Views Bulk Operations) are
satisfied. After enabling, you still need to add the operations to the content view
and grant permissions — see [Configuration](../configuration/index.md).

There are no submodules.
