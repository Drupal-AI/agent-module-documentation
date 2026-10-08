# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Filter** (`filter`) and **Text** (`text`) modules — enabled
  automatically as dependencies.
- The **CommonMark** and **HTML-to-Markdown** PHP libraries, installed through
  Composer (installing the module with Composer, as below, pulls these in for
  you).
- PHP's **ZipArchive** extension — required for archive export and verification.
  It ships with most PHP builds and is present in DDEV by default.

Optional integrations activate automatically only when the supporting module is
installed: **Media**, **Entity Reference Revisions**, **Paragraphs**, and
**Webform**. None of these are required for the core validate/import/export/diff
workflow.

## Install with Composer

From the project root:

```bash
composer require drupal/content_packages -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — and, importantly here, brings in the CommonMark and
HTML-to-Markdown libraries the module depends on.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_packages -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_packages -y
```

## Verify it worked

The module is CLI-only, so the quickest check is to list its Drush commands:

```bash
drush list --filter=content-packages
```

You should see `content-packages:validate`, `:import`, `:export`,
`:archive:export`, `:archive:verify`, `:archive:import`, `:diff`, and
`:assets:cleanup`. If those appear, the module and its libraries are installed
correctly. See the main guide's [How to use it](../index.md#how-to-use-it)
section for what each command does.
