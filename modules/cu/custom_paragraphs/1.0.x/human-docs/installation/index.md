# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal core's **Editor** module (for the optional CKEditor 5 rich-text field
  support). It ships with core; enable it if you use that field type.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_paragraphs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/custom_paragraphs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_paragraphs -y
```

## Verify it worked

Custom Paragraphs is a developer library, so there is nothing visible in the admin
UI to check. Confirm success by wiring the library into one of your own custom
forms (see ["How to use it"](../index.md#how-to-use-it)) and loading that form —
the repeatable "add another item" controls should appear and let you add and
remove groups.
