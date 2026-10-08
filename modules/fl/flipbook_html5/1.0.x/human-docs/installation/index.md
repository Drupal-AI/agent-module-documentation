# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **File** module (`file`) — enabled by default on most sites.
- The **PDF** module (`pdf`) — a contributed dependency, installed automatically by
  the Composer command below.
- The **PDF.js** and **PageFlip** libraries do the rendering client-side; the
  module handles attaching them.

## Install with Composer

From the project root:

```bash
composer require drupal/flipbook_html5 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the `pdf`
dependency and any shared libraries alongside the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flipbook_html5 -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flipbook_html5 -y
```

Drupal will enable the required **File** and **PDF** modules as dependencies if
they are not already on.

## Verify it worked

Go to **Structure → Content types → *(a type with a file field)* → Manage
display**. Open the **Format** dropdown for the file field — **Flipbook HTML5
Reader** should be listed. Select it, save, and view a node whose field holds a PDF
to confirm the flipbook renders.
