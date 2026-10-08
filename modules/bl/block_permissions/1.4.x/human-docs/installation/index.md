# Installation

## Requirements

Block Permissions has no third-party libraries and no module dependencies beyond
Drupal core. It needs:

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Block** module, which provides the Block layout screens the permissions
  refine (always present on a standard site).

## Install with Composer

From the project root:

```bash
composer require drupal/block_permissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/block_permissions -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_permissions -y
```

There are no submodules. As soon as it's on, the new per-theme and per-provider
permissions appear on **People → Permissions**, and the extra access checks are
active on the Block layout screens.

> **Heads-up:** enabling the module tightens access immediately. A role that
> previously had only core's **Administer blocks** will now *also* need the
> permission for your default theme to reach `/admin/structure/block` — otherwise it
> gets a 403. Grant those permissions right after enabling; see
> [Configuration](../configuration/index.md).

## Verify it worked

Go to **People → Permissions** and search for "block". Alongside core's **Administer
blocks** you should now see entries like *Administer block settings for the theme
Olivero* and *Manage blocks provided by …* for each installed theme and each block
provider on your site.
