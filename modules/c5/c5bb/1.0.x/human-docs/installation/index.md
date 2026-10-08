# Installation

## Requirements

- **Drupal 10.5 or 11** (`core_version_requirement: ^10.5 || ^11`).
- Core **CKEditor 5** module (`ckeditor5`), enabled automatically as a dependency.

There are no third-party Composer or PHP library requirements. Note that Bootstrap's
own button CSS is **not** bundled — your theme must supply it for the buttons to look
right on the front end (see [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/c5bb -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/c5bb -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en c5bb -y
```

## After enabling

The button isn't on any toolbar yet. Head to
[Configuration](../configuration/index.md) to add the **Bootstrap Buttons** item to a
text format's CKEditor 5 toolbar and set up its class options.
