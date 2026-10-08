# Installation

## Requirements

Layout Builder Quick Add extends core Layout Builder. It needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`) enabled — this is the only
  dependency, and Drupal will enable it (and its own dependencies) automatically.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_quick_add -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_quick_add -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_quick_add -y
```

## Verify it worked

Edit a page that uses Layout Builder and click **Add block**. Instead of the
off‑canvas sidebar sliding out, you should see a selection of block types shown
directly, with a **See more blocks** link to reach the standard core workflow if you
need it. To fine‑tune the chooser, see [Configuration](../configuration/index.md).
