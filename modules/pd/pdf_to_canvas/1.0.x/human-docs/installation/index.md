# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`). Verify
  compatibility before relying on it under Drupal 11.

There are no other module dependencies, no third‑party Composer or PHP library
requirements, and no server‑side rendering tools to install — the PDF is drawn in
the browser with pdf.js, which the module attaches for you.

> **Heads up:** this project is **not covered by Drupal's security advisory
> policy**. Review it as you would any uncovered contrib module before relying on
> it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/pdf_to_canvas -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pdf_to_canvas -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pdf_to_canvas -y
```

## Verify it worked

Go to **Structure → Content types → *(a type with a PDF file field)* → Manage
display**. The field's **Format** dropdown should now include **PDF to canvas**.
Select it, save, and view a piece of content with a PDF attached — the document
should render inline on a canvas element rather than as a download link.
