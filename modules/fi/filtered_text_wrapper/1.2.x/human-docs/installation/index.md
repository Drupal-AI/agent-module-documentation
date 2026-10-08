# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **PHP 7.4** or newer (`php_requirement: 7.4`).
- Core's **Filter** module (`filter`) enabled — Drupal enables it automatically as
  a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/filtered_text_wrapper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/filtered_text_wrapper -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en filtered_text_wrapper -y
```

Enabling the module makes the **Wrapper** filter available to add to your text
formats; it does not change any content until you turn the filter on.

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`) and configure a format. Confirm **Wrapper**
appears in the **Enabled filters** list, tick it, keep or change the default
prefix/suffix, order it last, and save. View content that uses that format — its
output should now be wrapped in your container element (by default
`<div class="wysiwyg">`). See the [main guide](../index.md#how-to-use-it) for the
full walkthrough.
