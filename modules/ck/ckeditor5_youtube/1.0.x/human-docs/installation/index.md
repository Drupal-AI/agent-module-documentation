# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — the only dependency, and part of
  Drupal core.

There are no third‑party Composer or PHP library requirements — the `lite-youtube` web
component and responsive CSS are bundled inside the module.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_youtube -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor5_youtube -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_youtube -y
```

## Turn it on for a text format

Enabling the module does not, on its own, add the button anywhere — you switch it on per text
format. Go to **Configuration → Content authoring → Text formats and editors**, edit a
CKEditor 5 format, and drag the **YouTube Embed** button into the active toolbar. See the
[main page](../index.md#how-to-use-it) for the full walkthrough and the attribute options.
