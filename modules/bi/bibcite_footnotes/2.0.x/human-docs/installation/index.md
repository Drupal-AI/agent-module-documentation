# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Bibcite** suite (`bibcite`, and Bibcite Entity) — install and enable
  Bibcite first if it is not already present (`composer require drupal/bibcite`).
- Core's **CKEditor 5** module (`ckeditor5`), which provides the rich-text
  editor this plugin extends.

This is a **beta** release (2.0.0-beta1); test it before relying on it in
production.

## Install with Composer

From the project root:

```bash
composer require drupal/bibcite_footnotes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Bibcite
dependencies and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bibcite_footnotes -W`, `ddev
> drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bibcite_footnotes -y
```

Drupal enables the Bibcite and CKEditor 5 dependencies automatically. There is
no configuration page — to use the tool, add its button to a CKEditor 5 text
format toolbar as described in the [main guide](../index.md).
