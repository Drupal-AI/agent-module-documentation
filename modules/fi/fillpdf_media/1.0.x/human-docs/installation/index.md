# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **FillPDF** module (`fillpdf`) — a hard dependency, and it needs its own
  PDF‑processing backend configured (see FillPDF's documentation).
- Core's **Media** module (`media`) — a declared dependency, enabled by default on
  most sites.

> **Heads up:** This project is **not covered by Drupal's security advisory
> policy**. Weigh that before using it on a production site.

## Install with Composer

From the project root, require FillPDF and this module together:

```bash
composer require drupal/fillpdf drupal/fillpdf_media -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fillpdf_media -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the modules

```bash
drush en fillpdf media fillpdf_media -y
```

## Create the `pdf` media type

FillPDF Media keys off a media type whose **machine name is `pdf`**. Create it
once:

1. Go to **Structure → Media types → Add media type**
   (`/admin/structure/media/add`).
2. Give it a label (for example "PDF") and set the **machine name** to exactly
   **`pdf`**.
3. Choose an appropriate **media source** (typically **File**) so it can hold PDF
   documents, and save.

## Verify it worked

Upload a fillable PDF as a **PDF** media entity (**Content → Media → Add media**).
Open it and confirm you can reach a link to **edit its FillPDF form**, and that the
media‑irrelevant FillPDF form elements are hidden. If FillPDF itself is not yet
producing filled PDFs, revisit FillPDF's own configuration first.
