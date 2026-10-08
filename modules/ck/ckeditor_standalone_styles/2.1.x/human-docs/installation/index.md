# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — the only dependency.

There are no third-party Composer packages or external JavaScript libraries.

> **Version note:** The 2.x series (including this 2.1.x release) targets the
> CKEditor 5 editor provided by Drupal 10/11 core. Older 2.0.x builds targeted the
> contrib CKEditor 4 module; use 2.1.x for a modern CKEditor 5 site.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_standalone_styles -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor_standalone_styles -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_standalone_styles -y
```

## Verify it worked

Visit **Configuration → Content authoring → CKEditor styles**
(`/admin/config/content/ckeditor_style`). If the page loads and lets you add a
style, the module is active. Next, follow
[Configuration](../configuration/index.md) to make sure the **Styles** button is
on your format's toolbar and to grant the management permission.
