# Installation

## Requirements

Admin Toolbar Language Switcher is lightweight. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Language** module (`language`) and **Toolbar** module (`toolbar`)
  enabled — these are the only dependencies, and Drupal enables them
  automatically when you turn on this module.
- More than one language enabled for the switcher to have anything to do.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/toolbar_language_switcher -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/toolbar_language_switcher -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en toolbar_language_switcher -y
```

## Grant the permission

The switcher only renders for users who hold the **`use toolbar_language_switcher`**
permission. Grant it at **People → Permissions**
(`/admin/people/permissions`), or from the command line:

```bash
drush role:perm:add editor 'use toolbar_language_switcher'
```

There is no settings form and no further configuration — with the permission
granted and more than one language enabled, the toolbar control appears
immediately.
