# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **CKEditor 5** module (`ckeditor5`), which Drupal enables automatically
  as a dependency.

There are no third-party Composer packages or PHP library requirements, and no
contrib dependencies. This module is covered by Drupal's security advisory
policy.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_sup_fix -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ckeditor5_sup_fix -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_sup_fix -y
```

## Verify it worked

Edit a CKEditor 5 text format (**Configuration → Content authoring → Text formats
and editors**), add the **Sup Fix Dummy** button to the toolbar, and save. Then
edit content that contains superscript or nested-anchor markup and confirm it is
preserved after saving rather than stripped or altered. See the
[main guide](../index.md#how-to-use-it) for the steps.
