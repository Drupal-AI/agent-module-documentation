# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Content Translation** (`content_translation`) and **Language**
  (`language`) modules, which Drupal enables as dependencies. Your site needs to
  be multilingual with at least two configured languages for the report to be
  meaningful.

There are no third-party Composer or PHP library requirements. If your content
uses the **Paragraphs** module, the report will include fields inside paragraphs
too.

## Install with Composer

From the project root:

```bash
composer require drupal/translate_side_by_side -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/translate_side_by_side -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en translate_side_by_side -y
```

Drupal enables Content Translation and Language as dependencies at the same time.

## Next step

Open the report and set it up — continue to
[Configuration](../configuration/index.md).
