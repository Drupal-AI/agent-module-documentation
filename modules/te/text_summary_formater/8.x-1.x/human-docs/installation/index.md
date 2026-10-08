# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Text** module (`text`) — the only dependency, which Drupal enables
  automatically as a dependency when you turn on this module.
- No third-party Composer or PHP library requirements.

## Mind the spelling

This project has a name mismatch, and each spelling only works in one place:

- The drupal.org **project / Composer package** is misspelled with **one `t`**:
  `drupal/text_summary_formater`.
- The **module machine name** you enable is spelled correctly with **two `t`s**:
  `text_summary_formatter`.

Use each spelling where it belongs (as shown below) and both commands succeed;
swap them and they fail.

## Install with Composer

From the project root — note the **one-`t`** package name:

```bash
composer require drupal/text_summary_formater -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/text_summary_formater -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Note the **two-`t`** machine name here:

```bash
drush en text_summary_formatter -y
```

## Verify it worked

On a content type with a text-with-summary field (such as an article **Body**),
go to **Manage display** and confirm that **Summary Only** is available as a
formatter for that field. Choose it, save, and view a node: only the
editor-written summary should show, and the field should be empty for nodes with
no summary.
