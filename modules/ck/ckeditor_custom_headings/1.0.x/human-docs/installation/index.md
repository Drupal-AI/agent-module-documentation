# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`), which ships with Drupal.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_custom_headings -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_custom_headings -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_custom_headings -y
```

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**, configure
a CKEditor 5 format that has the **Heading** button on its toolbar, and confirm a
new **Headings** tab appears under the CKEditor 5 plugin settings. That is where
you define your custom headings — see [Configuration](../configuration/index.md).
