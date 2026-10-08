# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`; the project also
  states it works with Drupal 8 and 9).
- Core's **Filter** module (`filter`), which is part of a standard Drupal install
  and provides the text-format filter system this module plugs into.

There are no third-party Composer packages or PHP libraries to install. It makes
the most sense alongside core **CKEditor 5**, since working around CKEditor's
forced paragraph tags is its main use case.

## Install with Composer

From the project root:

```bash
composer require drupal/strippfilter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/strippfilter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en strippfilter -y
```

## Turn on the filter

Enabling the module does not change any output on its own — you have to switch the
filter on within a text format. Go to **Configuration → Content authoring → Text
formats and editors** (`/admin/config/content/formats`), edit (or create) the
format you want to make inline, enable the **Strip paragraph tags** filter, and
make sure it runs **last**. There is more detail on the module's
[main guide](../index.md#how-to-use-it).
