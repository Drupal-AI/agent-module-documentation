# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **[Entity Clone](https://www.drupal.org/project/entity_clone)** module — this
  module extends it, and the actual cloning is done by Entity Clone. Composer pulls
  it in with the command below.
- Core's **Views** and **Image** modules (both standard on a normal Drupal site) for
  the template gallery and the preview images.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_clone_template -W
```

This installs Entity Clone Template together with its Entity Clone dependency. The
`-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_clone_template -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_clone_template -y
```

Or enable **Entity Clone Template** from *Extend* (`/admin/modules`). Drupal will
enable Entity Clone (and Views/Image) at the same time if they aren't already on.

There are no submodules. After enabling, grant the **Administer entity_clone_template**
permission to the editors who should curate templates, then enable the feature on the
content types you want — see [Configuration](../configuration/index.md).

> **Clean uninstall.** The module adds two hidden fields to all nodes. When you
> disable the feature for a content type its handlers clear those values, which lets
> Drupal uninstall the module cleanly even if templates had been defined.
