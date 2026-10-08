# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Image** module (`image`).
- Core's **Link** module (`link`).

Both dependencies are enabled automatically when you turn on Image Link Attributes.
There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/image_link_attributes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_link_attributes -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_link_attributes -y
```

## Verify it worked

Go to a content type's **Manage display**, set an image field to link **to content**
or **to file**, and open the formatter settings. You should now see additional
settings for **Class**, **Target** and **Rel** (and, on recent versions, a "Link to
alternate Image Style" option). See [Configuration](../configuration/index.md) for
how to use them.
