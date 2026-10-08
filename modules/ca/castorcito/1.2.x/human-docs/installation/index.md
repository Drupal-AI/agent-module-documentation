# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- No third-party Composer or PHP library requirements, and no other contrib
  module dependencies for the base module.

Because components use **Single Directory Components (SDC)**, they rely on SDC
support in core (available in Drupal 10.1+, stable from 10.3).

> **Beta / security coverage:** this is version **1.2.1-beta5** and the project
> is **not** covered by Drupal's security advisory policy. Evaluate accordingly
> before deploying to production.

## Install with Composer

From the project root:

```bash
composer require drupal/castorcito -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/castorcito -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en castorcito -y
```

## Submodules

Castorcito ships four optional submodules. Enable only the ones you need with
`drush en`:

| Submodule | What it adds |
|-----------|--------------|
| **Base pack** | A set of ready-to-use components: accordion, banner, bar, card, carousel, content in columns, data number card, icons in columns, image gallery, image, placed block, quote, slideshow, tabs, text, and video. |
| **Advanced pack** | Components with advanced functionality — currently a timeline (more planned). |
| **Webform** | Adds a "c-field" (Castorcito field) that lets you embed a webform inside a component. |
| **Sync** | Export and import components between sites. |

For example, to start with the base component pack:

```bash
drush en castorcito_base_pack -y
```

(Check the module's own listing at **Extend** for the exact submodule machine
names shipped with your downloaded version.)

## Verify it worked

After enabling, visit the Castorcito component collection (see
[Configuration](../configuration/index.md)). If you enabled the base pack, you
should be able to install its prebuilt components and then begin assembling them
into content.
