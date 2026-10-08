# Installation

## Requirements

- **Drupal 10.5 or 11** (`core_version_requirement: ^10.5 || ^11`).
- Drupal core's **CKEditor 5** module (`ckeditor5`) — a direct dependency,
  enabled with the module.
- Drupal core's **Filter** module (part of core) — the display filter that
  transforms `<pullquote>` elements on render.

No external libraries or contributed dependencies are required.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_pullquote -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor5_pullquote -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_pullquote -y
```

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**, edit a
CKEditor 5 format, and confirm the **Pullquote** button appears in the *Available
toolbar items*. Follow the [Configuration](../configuration/index.md) guide to
place the button and set up style variants, then create a pullquote in some
content and confirm it renders as a styled pull-out on the page.
