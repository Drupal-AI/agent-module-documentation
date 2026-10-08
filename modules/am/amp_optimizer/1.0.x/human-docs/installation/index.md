# Installation

## Requirements

- **Drupal 8.9, 9, or 10** (`core_version_requirement: ^8.9 || ^9 || ^10`).
- The **`ampproject/amp-toolbox`** PHP library, which provides the
  transformation engine that does the actual optimizing. Composer pulls it in
  with the module.
- Pages that are actually **AMP** — the optimizer transforms AMP markup, so it
  makes sense alongside an AMP theme/route setup.

## Install with Composer

From the project root:

```bash
composer require drupal/amp_optimizer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and installs the `ampproject/amp-toolbox` library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/amp_optimizer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en amp_optimizer -y
```

Once enabled, the optimizer runs automatically for anonymous visitors on HTML
responses. You can review and adjust its behavior on the settings form — see
[Configuration](../configuration/index.md).
