# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — this is the only dependency,
  and Drupal enables it for you if needed. At least one of your text formats must
  use CKEditor 5 as its editor for the button to be available.

There are no third-party Composer or PHP library requirements, and the module adds
no permissions or settings.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_emoji -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_emoji -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_emoji -y
```

Enabling the module makes the **Emoji** button available in the text-editor
configuration UI, but it does not appear for authors until you add it to a text
format's toolbar. See [How to use it](../index.md#how-to-use-it) in the main guide
for that final step — it takes about a minute.
