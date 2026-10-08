# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** (`field`) and **Node** (`node`) modules — both are standard
  parts of a normal Drupal install and are enabled automatically as dependencies
  if they aren't already.

No third‑party Composer packages or external libraries are needed.

> **Heads up:** this project is *not covered by Drupal's security advisory
> policy*. That doesn't mean it is unsafe, but it does mean security issues aren't
> tracked through the official process — worth weighing before you use it on a
> production site.

## Install with Composer

From the project root:

```bash
composer require drupal/json_to_content -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/json_to_content -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en json_to_content -y
```

You can also enable it from **Extend** (`/admin/modules`).

## Verify it worked

Log in as an administrator and visit
**`/admin/config/content/json-content-builder`**. You should see the "build a
content type from JSON" form. If it loads, the module is installed and ready —
see the "How to use it" section of the [overview](../index.md) for the three
working pages it provides.
