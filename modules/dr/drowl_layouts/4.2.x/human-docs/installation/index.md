# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3||^10||^11`).
- Module dependencies (Composer and Drupal pull these in):
  - Core **Layout Discovery** (`layout_discovery`) and **Layout Builder**
    (`layout_builder`).
  - **Twig Real Content** (`twig_real_content`) — used for realistic section
    previews.
- To render the layouts as intended you should be using a **ZURB Foundation 6.x**
  based theme; the module sets Foundation grid classes in its templates.
- If you use custom layouts defined in a theme, you may need the patch from core
  issue [#2904550](https://www.drupal.org/project/drupal/issues/2904550) to keep
  configuration import/export working.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/drowl_layouts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/drowl_layouts -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drowl_layouts -y
```

## Verify it worked

Enable Layout Builder on a content type (**Structure → Content types → *(type)* →
Manage display → Manage layout**) or open a Layout Paragraphs field. When you add
a section, the DROWL Foundation layouts should now appear in the list of available
layouts, each with its column, alignment, width, and gutter options.
