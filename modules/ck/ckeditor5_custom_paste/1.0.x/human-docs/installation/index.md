# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — this is the only
  dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_custom_paste -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor5_custom_paste -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_custom_paste -y
```

After enabling, configure the plugin on the text formats where you want it — see
[Configuration](../configuration/index.md).

## Verify it worked

Once you have enabled the plugin on a CKEditor 5 text format (see Configuration),
copy some richly formatted content from Word or Google Docs and paste it into a
content edit form using that format. The pasted markup should be cleaned up
according to your rules, while any tags you listed as excluded are left intact.
