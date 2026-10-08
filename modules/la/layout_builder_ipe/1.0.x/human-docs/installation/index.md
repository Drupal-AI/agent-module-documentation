# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`) enabled — this is the only
  dependency, and Drupal enables it automatically when you turn on Layout Builder
  IPE.

There are no third‑party Composer or PHP library requirements. (This version is a
release candidate, `1.0.0-rc1`.)

> **Security advisory coverage:** this project is **not covered** by Drupal's
> security advisory policy. Weigh that before using it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_ipe -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_ipe -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_ipe -y
```

After enabling, grant this module's permissions to the roles that should manage
layouts in place — see [Configuration](../configuration/index.md).

## Verify it worked

As a user with the right permissions, open the full page of a content entity whose
display uses Layout Builder and allows per‑entity customization. A **Customize**
link should appear at the bottom of the page; clicking it should replace the
content area with the Layout Builder editing interface. If it does, the module is
working.
