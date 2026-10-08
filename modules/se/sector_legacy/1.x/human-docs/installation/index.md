# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`). It is **not**
  compatible with Drupal 9.
- No hard module dependencies of its own. It is intended for **Sector**
  distribution / theme sites carrying legacy features forward.

There are no third-party PHP or library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/sector_legacy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/sector_legacy -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

The base module does not need to be enabled unless your site uses the legacy
features. If you do need it:

```bash
drush en sector_legacy -y
```

## Submodules — enable only what you need

The legacy features live in three submodules. Enable individually with `drush en`,
and only if your site actually relies on them:

| Submodule | Machine name | What it provides |
|-----------|--------------|------------------|
| **Sector Blocks** | `sector_blocks` | Legacy Sector block functionality carried forward from older builds. |
| **Admin UI Toggle** | `admin_ui_toggle` | The legacy admin-UI toggle feature. |
| **Sector Utils** | `sector_utils` | Legacy Sector utility helpers. |

For example, to enable just the legacy blocks:

```bash
drush en sector_blocks -y
```

## Verify it worked

Because this module exists to keep older Sector functionality working, the best
verification is functional: confirm that the legacy feature your site depends on
(a legacy block, the admin UI toggle, or a util) behaves as before after enabling
the corresponding submodule. Re-check whether you still need it after each Sector
upgrade.
