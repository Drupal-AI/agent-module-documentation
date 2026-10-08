# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The [Paragraphs](https://www.drupal.org/project/paragraphs) module (`paragraphs`)
  enabled — this is the only dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_auto_anchor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_auto_anchor -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_auto_anchor -y
```

That's all it takes. There is no configuration step.

## Verify it worked

Open any page that renders Paragraphs and view its source (or use your browser's
developer tools) — you should see an anchor target with the paragraph's UUID as
its id at the top of each paragraph. Then edit a piece of content with a
Paragraphs field: each paragraph in the widget should now show a **Copy anchor to
clipboard** button. Click it, append the copied `#<uuid>` fragment to the page
URL, and reload — the page should scroll straight to that paragraph.
