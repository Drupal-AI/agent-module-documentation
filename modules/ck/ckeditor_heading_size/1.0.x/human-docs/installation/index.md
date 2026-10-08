# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- CKEditor as your text editor.

The module has no declared module dependencies and no third‑party PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_heading_size -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_heading_size -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_heading_size -y
```

## Verify it worked

Go to **Configuration → Content authoring → CKEditor Heading Size**
(`/admin/config/content/ckeditor-heading-size`) and confirm the settings form
loads. Define your font‑size options there — see
[Configuration](../configuration/index.md) — then edit a piece of content and
check that the heading context menu offers those sizes.
