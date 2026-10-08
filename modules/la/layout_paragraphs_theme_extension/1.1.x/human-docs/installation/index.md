# Installation

## Requirements

- **Drupal 11 or 12** (`core_version_requirement: ^11 || ^12`).
- The **Layout Paragraphs** module (`layout_paragraphs`).
- The **Paragraphs** module (`paragraphs`).

Both dependencies should already be installed and configured — this module only
extends the Layout Paragraphs builder. There are no third‑party Composer or PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_paragraphs_theme_extension -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in or update
Layout Paragraphs and Paragraphs as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_paragraphs_theme_extension -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_paragraphs_theme_extension -y
```

## Verify it worked

After enabling, go to **Configuration → Content authoring → Layout Paragraphs →
Default Theme** (`/admin/config/content/layout_paragraphs/default-theme`) and
confirm the settings form appears. The extension does nothing until you tick
**Display default theme in admin** and rebuild caches — see
[Configuration](../configuration/index.md).
