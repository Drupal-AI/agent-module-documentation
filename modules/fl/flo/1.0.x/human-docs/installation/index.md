# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) — must be the selected editor for the
  text format you want to use this on.
- Core's **Editor** module (`editor`).
- **General HTML Support (GHS)** enabled on the text format, with `<ol class>` in
  the allowed elements, so the CSS classes the plugin adds are not stripped.

There are **no external JavaScript libraries, PHP packages, or third-party APIs** —
the plugin is vanilla JavaScript with no build step.

## Install with Composer

From the project root:

```bash
composer require drupal/flo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flo -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flo -y
```

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**, edit a
CKEditor 5 text format, and check that the **List Style per Level** button is
available to add to the toolbar. See "How to use it" on the
[overview page](../index.md) for the full toolbar and GHS setup.
