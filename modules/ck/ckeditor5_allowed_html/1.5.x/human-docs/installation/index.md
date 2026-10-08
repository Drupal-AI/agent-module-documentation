# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- CKEditor 5 as your text-format editor (core in Drupal 10/11).

There are no third-party Composer or PHP library requirements.

> **Note:** this is a development release (`1.5.x-dev`), minimally maintained, and not
> covered by Drupal's security advisory policy. Because the filter widens allowed HTML,
> review it carefully before using it on formats available to untrusted users.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_allowed_html -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor5_allowed_html -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_allowed_html -y
```

## Turn on the filter

Enabling the module does not change any text format by itself. On the format you want
to extend, enable the **Editable tag list** version of the "Limit allowed HTML tags"
filter (in place of the core one) and edit its allowed-tags list. Those steps are in
the [guide](../index.md#how-to-use-it-in-a-text-format).

## Verify it worked

Edit a text format and confirm **Limit allowed HTML tags and correct faulty HTML —
Editable tag list** appears in the filter list. Enable it, and check that its
**Allowed HTML tags** field is now editable (not read-only). Add a test tag, save, and
confirm that content using that tag now round-trips through the editor without being
stripped.
