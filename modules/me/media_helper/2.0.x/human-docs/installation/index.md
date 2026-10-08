# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **File**, **Image**, and **Media** modules — Drupal enables these as
  dependencies automatically.
- *(Optional)* The **Responsive Image** core module if you want to pass responsive
  image style names to the Twig filters.
- *(Optional)* The **SVG Image** and/or **SVG Image Field** contributed modules if
  you want SVG sizing support — enable them only if you use SVGs (see
  [Configuration](../configuration/index.md)).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_helper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_helper -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_helper -y
```

## Verify it worked

Add one of the Twig filters to a template — for example
`{{ node.field_media_image|media_image('thumbnail') }}` in a node template — clear
caches, and confirm the styled image renders. Or, on an entity's **Manage
display**, check that a media reference field now offers the **Rendered image**
formatter.
