# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11 || ^12 || ^13 ||
  ^14 || ^15` — the module declares forward compatibility well beyond current
  core).
- **PHP 8.3** or newer.
- The **Entity API** contrib module (`entity:entity`).
- Core modules pulled in as dependencies: `field`, `text`, and `options`.
- **Optional:** the **Search API EAV Field** contrib module if you want to index
  EAV values with Search API.

## Install with Composer

From the project root:

```bash
composer require drupal/eav_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Entity API and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eav_field -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eav_field -y
```

This pulls in Entity API, field, text, and options if they are not already
enabled. Afterwards, grant the **Administer EAV attributes** (`administer eav
attributes`) permission to the roles that will manage attributes.

## Verify it worked

Go to **Structure → EAV → Attributes** (`/admin/structure/eav/attributes`). If
the attributes listing loads, the module is installed correctly. Next, define
your first attribute and attach the EAV field to a bundle, as described in
[Configuration](../configuration/index.md).
