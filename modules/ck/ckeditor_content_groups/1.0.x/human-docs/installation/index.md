# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`), which ships with Drupal.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_content_groups -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_content_groups -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_content_groups -y
```

## Submodules

- **CKEditor Content Groups Schema** (`ckeditor_content_groups_schema`) — optional.
  It provides schema‑aware variants of the widgets that emit JSON‑LD structured
  data (FAQPage for accordions, ItemList for tabs), with a per‑instance on/off
  toggle, to help search engines understand the content. Enable it only if you
  want that SEO structured data:

  ```bash
  drush en ckeditor_content_groups_schema -y
  ```

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**, configure
a CKEditor 5 format, and confirm that **Accordion**, **Horizontal tabs**, and
**Vertical tabs** buttons are available in the toolbar‑configuration tray. Drag
the ones you want into the active toolbar and save — then continue to
[Configuration](../configuration/index.md).
