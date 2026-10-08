# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **File** module (`file`), enabled automatically as a dependency.
- The **pdf.js library**, downloaded and placed under `/libraries/pdf.js/` — this is
  **not** bundled with the module and is required for anything to render (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/pdf -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pdf -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pdf -y
```

There are no submodules.

## Install the pdf.js library (required)

This is the step people miss. The module expects Mozilla's pdf.js viewer unpacked at
the docroot path `/libraries/pdf.js/`. Until it's there, the iframe 404s and the
thumbnails stay blank — and the module gives **no** warning on the status report, so
it's easy to overlook.

1. Download a pdf.js prebuilt release from
   <https://mozilla.github.io/pdf.js/getting_started/> (the "Stable" prebuilt zip).
2. Unpack it so that your web root contains these files:
   - `libraries/pdf.js/build/pdf.js`
   - `libraries/pdf.js/build/pdf.worker.js`
   - `libraries/pdf.js/web/viewer.html`

That's the whole library setup — no configuration needed for the default viewer path.

## Grant the permission (optional)

Only users with **Administer PDF.js** can open the settings form. By default that's
administrators. To grant it to another role:

```bash
drush role:perm:add editor 'administer pdfjs'
```

Note this permission only gates the settings page. Whether a visitor can see a
rendered PDF is governed by the normal file-field access rules.

## Verify it worked

Add a core **File** field to a content type (allowing the `pdf` extension), set its
format to **PDF: Default viewer of PDF.js** on **Manage display** (see
[Configuration](../configuration/index.md)), then view a node with a PDF attached. You
should see the document rendered inline with page navigation. If you get a blank area
or a 404, re-check the pdf.js library paths above.
