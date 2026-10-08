# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).
- The **CKEditor** module (`ckeditor`) — the legacy CKEditor 4 editor this plugin
  targets. (CKEditor 4 is not part of Drupal 10 core; you install the contrib
  `ckeditor` module for it.)

The module requires nothing else outside Drupal core, and there are no third‑party
PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_glossary -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_glossary -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_glossary -y
```

## Verify it worked

Configure a CKEditor 4 text format, add the **Link to Glossary** button to its
toolbar, and set the **Path to glossary page** (or leave it blank for `/glossary`).
Save, then edit content in that format: selecting a word and clicking the button
should wrap it in a link such as `/glossary/a#apple`.
