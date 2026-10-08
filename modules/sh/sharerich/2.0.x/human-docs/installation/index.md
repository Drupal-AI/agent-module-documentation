# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Token** module (`token`) — required, for the `[sharerich:*]` token
  substitution in button markup.
- Core's **Block** module (`block`) — required, since the buttons are rendered as a
  block.

Composer pulls Token in for you when you install with `-W`; Block ships with Drupal
core.

## Install with Composer

From the project root:

```bash
composer require drupal/sharerich -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the required Token module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sharerich -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sharerich -y
```

This also enables Token and Block if they are not already on.

## Grant the permission

All of Sharerich's admin pages are controlled by the restricted **Administer
sharerich** (`administer sharerich`) permission. Go to **People → Permissions**
(`/admin/people/permissions`) and grant it only to roles you trust — this permission
allows editing raw button markup.

## Next step

With the module enabled, build a button set, set your global options, and place the
block. See [Configuration](../configuration/index.md).
