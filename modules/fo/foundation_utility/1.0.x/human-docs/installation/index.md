# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Core's **CKEditor 5** (`ckeditor5`) and **Editor** (`editor`) modules — these are
  dependencies and Drupal enables them automatically. They're what provide the
  text‑format and WYSIWYG machinery the filter plugs into.
- A site themed with **ZURB Foundation**, so the table classes the filter adds have
  matching styles. This isn't a code dependency, but the styling only takes effect on
  a Foundation front end.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/foundation_utility -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/foundation_utility -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en foundation_utility -y
```

## Verify it worked

The module does nothing until you switch its filter on for a text format. Head to
**Configuration → Content authoring → Text formats and editors**, edit a format, and
confirm the Foundation table filter appears in the **Enabled filters** list. Then
follow [Configuration](../configuration/index.md) to turn it on and pick your
options.
