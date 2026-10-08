# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** module (`field`) — enabled on every standard Drupal site.
- Core's **Media** module (`media`) — required only if you want to embed PDFs that
  are referenced through Media entities.

There are no third‑party Composer or PHP library requirements, and no JavaScript
viewer library to install — the module relies on the browser's native PDF viewer.

> **Heads up:** this branch (1.0.x) is marked "no further development," and the
> project is **not covered by Drupal's security advisory policy**. For new sites,
> prefer the **1.1.x** branch.

## Install with Composer

From the project root:

```bash
composer require drupal/pdf_embed_view -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed. To pin this branch specifically, use
`composer require 'drupal/pdf_embed_view:^1.0' -W`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pdf_embed_view -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pdf_embed_view -y
```

If you plan to embed PDFs referenced through Media, make sure the core Media
module is enabled too:

```bash
drush en media -y
```

## Verify it worked

Go to **Structure → Content types → *(a type with a PDF File field)* → Manage
display**. The field's **Format** dropdown should now include **PDF Embed
Viewer**. Select it, pick a display mode, save, and view a piece of content with a
PDF attached — it should render inline (or as a modal/new‑tab link) instead of a
plain download link.
