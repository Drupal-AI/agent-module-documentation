# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The [**Mercury Editor**](https://www.drupal.org/project/mercury_editor) module
  (`^2.0`) — the page builder these templates plug into.
- The [**Layout Paragraphs**](https://www.drupal.org/project/layout_paragraphs)
  module (`^2.1`).
- The [**Paragraphs**](https://www.drupal.org/project/paragraphs) module (`^1.15`).
- Core's **File** module (for optional per‑template preview images).

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/mercury_editor_page_templates -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If you do not already have the companions installed, require
them too:

```bash
composer require drupal/mercury_editor drupal/layout_paragraphs drupal/paragraphs -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mercury_editor_page_templates -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mercury_editor_page_templates -y
```

Mercury Editor, Layout Paragraphs, Paragraphs, and core File are enabled
automatically as dependencies.

## Verify it worked

Go to **Configuration → Content authoring → Mercury Editor Page Templates**. You
should reach the template management interface, where you can add templates and open
the **Groups** tab. Then, when you create a page with Mercury Editor, a template
selector should offer any templates you have defined. See
[Configuration](../configuration/index.md) for the full walkthrough.
