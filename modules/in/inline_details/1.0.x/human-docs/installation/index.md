# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Filter** module (part of Drupal core), which provides the text-format
  system this filter plugs into.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/inline_details -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/inline_details -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en inline_details -y
```

Enabling the module does not switch the feature on by itself — you still need to
enable its filter on the text formats where you want the `(( ))` shorthand.

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), edit a text format, and confirm that the
**Inline Details** filter appears in the **Enabled filters** list. Tick it, save,
then create content using that format with some `((double bracketed text))` and
confirm it renders as an inline expandable details element. See "How to use it" on
the [overview page](../index.md) for details.
