# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- No other contrib modules and no third-party PHP libraries.

> **Before you enable it, understand the effect.** Enabling Paranoia immediately uninstalls
> the core **PHP** module (and `skinr_ui`), strips the admin flag from all roles, and revokes a
> list of PHP/eval permissions across every role. It also cannot be uninstalled from the UI
> afterwards. Make sure nothing on your site relies on the PHP module or the `use PHP for …`
> permissions first, and take a database backup before enabling on an existing site.

## Install with Composer

From the project root:

```bash
composer require drupal/paranoia -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/paranoia -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paranoia -y
```

The hardening applies on install and is then enforced automatically — there is nothing further
to configure. See **How to use it** in the [overview](../index.md) for the full list of what it
does.

## Uninstall (UI is blocked by design)

Paranoia deliberately hides itself from the modules and uninstall pages, so you cannot remove
it by clicking through the admin. Use Drush:

```bash
drush pm:uninstall paranoia
```

If that isn't possible, delete the module directory and clear caches (e.g. truncate
`cache_config` / run `drush cr`). After removal you may want to re-enable the PHP module or
restore permissions manually, since Paranoia will no longer be enforcing its lockdown.
