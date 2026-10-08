# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — this is the only
  dependency, and Drupal enables it automatically as a dependency.

There are no third-party Composer packages, no external JavaScript libraries, and
no build step.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_spacing -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor_spacing -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_spacing -y
```

## Verify it worked

Enabling the module alone does not change the editor — you still have to set it up
per text format. Head to
[Configuration](../configuration/index.md) to add the **Spacing** toolbar button
and enable the filter. Once that is done, edit a piece of content, place the caret
in a paragraph, click **Spacing**, and confirm you can set margin/padding and see
the change reflected on the published page.
