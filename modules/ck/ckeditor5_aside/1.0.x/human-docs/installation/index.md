# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — this is the only
  dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_aside -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor5_aside -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_aside -y
```

## Verify it worked

Edit a text format that uses CKEditor 5 (**Configuration → Content authoring →
Text formats and editors**) and open the block-format dropdown in the editor. You
should see **Aside** at the top of the list alongside *Paragraph* and the
headings. Apply it to a block and confirm the text is wrapped in `<aside>` — the
editor shows a bordered, shadowed box, and you can add matching front-end styles
in your theme.
