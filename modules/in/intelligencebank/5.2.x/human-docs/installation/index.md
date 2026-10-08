# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- An **IntelligenceBank account** with DAM access — the module is a bridge to that
  platform and needs credentials to connect.
- Your server must be able to reach IntelligenceBank over HTTPS.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root — note the Composer package name is `drupal/intelligencebank`:

```bash
composer require drupal/intelligencebank -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/intelligencebank -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

The module's **machine name is `ib_dam`**, so enable it by that name (not by the
Composer package name):

```bash
drush en ib_dam -y
```

## Submodules — enable only what you need

IntelligenceBank ships two optional submodules. Enable the ones that match how your
editors will insert assets:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **IB DAM Media** | `ib_dam_media` | Integrates IntelligenceBank with Drupal's core **Media Library**, so DAM assets can be browsed and used wherever the Media Library appears. |
| **IB DAM WYSIWYG** | `ib_dam_wysiwyg` | Lets editors insert DAM assets directly from the **rich‑text editor**. |

For example:

```bash
drush en ib_dam_media -y
```

## Verify it worked

Open the IntelligenceBank settings form (guarded by the **administer
intelligencebank configuration** permission). If it opens, the module is
installed. Continue to [Configuration](../configuration/index.md) to connect your
IntelligenceBank account.
