# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2||^11`).
- Core's **CKEditor 5** module (`ckeditor5`), which Drupal enables automatically
  as a dependency.

There are no third-party Composer packages or PHP library requirements. This
module is covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_spoiler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/ckeditor5_spoiler -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_spoiler -y
```

## Verify it worked

Edit a CKEditor 5 text format (**Configuration → Content authoring → Text formats
and editors**), add the **Spoiler** button to the toolbar, enable the **Spoiler
support** filter, and save. Then edit some content with that format and confirm
you can wrap a selection as a spoiler and that it hides/reveals on the rendered
page. See the [main guide](../index.md#how-to-use-it) for the full walkthrough.
