# Installation

## Requirements

- **Drupal 10 or newer** (`core_version_requirement: >=10`).
- **PHP 8.1 or newer**.

There are no other module dependencies and no third-party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/script_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/script_manager -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en script_manager -y
```

## Grant the permission — carefully

Script Manager ships one permission, **Administer scripts**, and it is marked as
security-sensitive (`restrict access: true`). Because snippets are output raw and
unescaped, this permission is effectively the ability to run any JavaScript on
every page of your site. **Grant it only to roles you fully trust** (typically
just administrators) at **People → Permissions**
(`/admin/people/permissions`).

Once enabled, head to [Configuration](../configuration/index.md) to add your
first snippet.
