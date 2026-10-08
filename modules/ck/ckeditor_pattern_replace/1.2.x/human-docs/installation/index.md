# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **CKEditor** module (`ckeditor`) as a dependency.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_pattern_replace -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor_pattern_replace -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_pattern_replace -y
```

## Verify it worked

The filter does nothing until you enable it on a text format and add at least one
rule — see [Configuration](../configuration/index.md). After configuring a rule,
view content that uses that format and confirm the output reflects your
search‑and‑replace.
