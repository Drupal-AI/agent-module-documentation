# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field UI** module (`field_ui`), which provides the *Manage form
  display* screens where you switch Reading Rating on per field. It is enabled as
  a dependency.
- A long-text field to rate (it works with CKEditor 5 and non-WYSIWYG text
  fields).

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/reading_rating -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/reading_rating -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en reading_rating -y
```

Core Field UI is enabled as a dependency if it is not already on.

## Verify it worked

Open the **Manage form display** of a content type that has a long-text field,
click the gear icon next to that field, and confirm a **Reading Rating** option
appears (see [Configuration](../configuration/index.md)). After enabling it and
saving, edit a piece of that content — the live readability score should appear
below the field as you type.
