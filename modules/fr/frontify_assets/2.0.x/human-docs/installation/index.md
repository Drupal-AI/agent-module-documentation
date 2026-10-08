# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **Frontify account** on the platform, from which you generate a **Client ID**
  (see [Configuration](../configuration/index.md)).
- **Optional:** the [Colorbox](https://www.drupal.org/project/colorbox) module if
  you want the Colorbox lightbox functionality (used by the submodule below).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/frontify_assets -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/frontify_assets -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en frontify_assets -y
```

## Submodules

- **Frontify Assets Colorbox** (`frontify_assets_colorbox`) — adds Colorbox
  (lightbox) support for Frontify assets, including in views. It works together with
  the contributed Colorbox module. Enable it only if you want that behaviour:

  ```bash
  drush en frontify_assets_colorbox -y
  ```

## Verify it worked

Log in as an administrator and go to **Configuration → Media → Frontify Settings**.
Once you have entered your Frontify API URL and Client ID there (see
[Configuration](../configuration/index.md)), the **Frontify Finder 2** browser
becomes available in your configured media/image fields and WYSIWYG editors.
