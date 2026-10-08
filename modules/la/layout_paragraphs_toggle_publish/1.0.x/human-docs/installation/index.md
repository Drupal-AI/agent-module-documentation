# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **Paragraphs** module (`paragraphs`).
- The **Layout Paragraphs** module, **version 2** (`layout_paragraphs ^2`).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_paragraphs_toggle_publish -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in or update
Paragraphs and Layout Paragraphs as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_paragraphs_toggle_publish -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_paragraphs_toggle_publish -y
```

## Verify it worked

Edit any content that uses a Layout Paragraphs field. In the builder, each
component should now show a **publish/unpublish** control next to its existing
edit, delete, and move controls. There is no configuration to do — the control is
active as soon as the module is enabled.
