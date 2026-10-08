# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- No dependencies beyond Drupal core for the standard renderers (Google Docs
  Viewer, Microsoft Office viewer, direct embed, and the bundled pdf.js viewer).

Only if you want the **Colorbox lightbox** renderer, you also need:

- **Colorbox** (`drupal/colorbox`) — adds the lightbox renderer option.
- **Libraries** (`drupal/libraries`) — required together with Colorbox.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/pdf_reader -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If you want the Colorbox renderer, add its modules too:

```bash
composer require drupal/pdf_reader drupal/colorbox drupal/libraries -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/pdf_reader -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pdf_reader -y
```

For the Colorbox renderer, also enable those modules:

```bash
drush en colorbox libraries -y
```

The module ships no submodules of its own.

## Verify it worked

Go to a bundle's **Manage display** screen (for example **Structure → Content
types → Article → Manage display**) for a content type that has a File, plain
text, or URI field holding a PDF. In that field's **Format** drop‑down you should
now see **PDF Reader**. Continue to [Configuration](../configuration/index.md) to
set it up.
