# Installation

## Requirements

Image Field Tokens needs:

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **Token** module (`drupal/token` `^1.5`) — pulled in automatically by
  Composer.
- Core's **Image** and **Media Library** modules enabled (dependencies).

Optional integrations enhance the module when present:

- **Image Widget Crop** (`drupal/image_widget_crop`) — adds a crop + tokens widget.
- **Colorbox** (`drupal/colorbox`) — adds a Colorbox formatter with token support.
- **IMCE** (`drupal/imce`) — file‑browser support for the token widgets.

## Install with Composer

From the project root:

```bash
composer require drupal/imagefield_tokens -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the required
**Token** module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/imagefield_tokens -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en imagefield_tokens -y
```

That enables the module and, if they aren't already on, its **Token**, **Image**,
and **Media Library** dependencies. There is no configuration step — see
[How to use it](../index.md#how-to-use-it) to switch a field's widget and
formatter over to Image Field Tokens.
