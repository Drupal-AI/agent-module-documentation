# Installation

## Requirements

- **Drupal 9.3 up to (but not including) 11** (`core_version_requirement:
  >=9.3 <11`). Note this release does not support Drupal 11.
- No third-party Composer libraries and no other module dependencies.

Before you install, read the end-of-life note in the [overview](../index.md):
the maintainers recommend the successor module *Glint* for new work, and warn of
a performance cost if Harmonize is used heavily.

## Install with Composer

From the project root:

```bash
composer require drupal/harmonize -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/harmonize -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en harmonize -y
```

## Submodules

Harmonize ships several optional submodules that extend the base framework.
Enable only the ones you need with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Refinery** | `harmonize_refinery` | Extra refinement of the harmonized output. |
| **Harmony file discovery** | `harmonize_harmony_file_discovery` | Discovery of `harmony`-related template files. |
| **SDC display** | `harmonize_sdc_display` | Render harmonized data through Single Directory Components. |
| **Examples** | `harmonize_examples` | Worked examples to learn from. |

For example:

```bash
drush en harmonize_sdc_display -y
```

## Verify it worked

Log in as a user with **Administer site configuration** and open
**Configuration → Harmonize** (`/admin/config/harmonize`). If the settings,
Entity Processing Rules, cache, and Visualizer screens are present, the module is
installed. Next, follow [Configuration](../configuration/index.md) to switch on
preprocessing for a bundle and start reading `{{ harmony }}` in your templates.
