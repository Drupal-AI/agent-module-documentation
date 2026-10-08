# Installation

## Requirements

Layout Builder Symmetric Translations needs:

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Layout Builder** module (`layout_builder`) enabled — its only declared
  dependency.
- Core's **Content Translation** module and at least one additional language, since
  the whole point is translating layout content.

**Incompatibility:** do **not** enable this alongside **Layout Builder Asymmetric
Translations** (`layout_builder_at`). The two provide competing translation models;
if both are enabled the site shows a requirements error. Choose one.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_st -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_st -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_st -y
```

Enabling it also turns on Layout Builder if it is not already active. On install the
module adds its hidden translation-storage field to any bundle that already has
Layout Builder overrides enabled, and it will do the same automatically for any
bundle where you enable overrides later. There is no settings page — see
[How to use it](../index.md#how-to-use-it) in the overview for translating your
first layout.
