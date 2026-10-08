# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — the only dependency,
  enabled automatically by Drupal when required.

There are no third-party Composer packages or external JavaScript libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_span -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor_span -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_span -y
```

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**, edit a
CKEditor 5 format, and drag the **Span** button into the active toolbar. Save,
then edit a piece of content: select some text, click the **Span** button, and
confirm the selection is wrapped in a `<span>` (you can check via the Source view
if your format enables it).
