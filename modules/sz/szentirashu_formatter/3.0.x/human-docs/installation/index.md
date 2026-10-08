# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field** module (`field`), which is part of a standard Drupal install and
  is enabled automatically as a dependency.
- An **API key from szentiras.eu** to fetch passage text.
- A text or string field holding Bible reference strings to apply the formatter to.
- No PHP extensions or external Composer libraries are listed as required.
- Note the module is **minimally maintained** and **not covered by the security
  advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/szentirashu_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/szentirashu_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en szentirashu_formatter -y
```

## Grant the permission

The module provides an **Administer szentirashu api** permission that controls access
to its settings form. At **People → Permissions** (`/admin/people/permissions`), grant
it only to trusted administrator roles.

## Verify it worked

Open the settings form (the `szentirashu_formatter.settings` route), enter your API
key and pick a default translation, then add the formatter to a field on a
**Manage display** screen. View an entity whose field holds a reference (for example
"Jn 3,16") and confirm the passage renders or loads. See
[Configuration](../configuration/index.md) for the details.
