# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — this is the only
  dependency, and Drupal enables it automatically as a dependency when you turn on
  this module. You'll need at least one text format that uses the CKEditor 5 editor.

There are no third-party PHP library requirements — the CKEditor 5 JavaScript
plugin ships built with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_id_attributes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_id_attributes -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_id_attributes -y
```

## Next steps

Enabling the module makes the **ID Attributes** button available but doesn't add it
anywhere. Add it to a CKEditor 5 text format's toolbar to switch it on — see
[Configuration](../configuration/index.md).
