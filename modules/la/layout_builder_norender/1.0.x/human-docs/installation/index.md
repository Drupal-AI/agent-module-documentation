# Installation

## Requirements

Layout Builder No Render is a helper for core Layout Builder. It needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **Layout Builder** module (`layout_builder`) enabled — this is the only
  dependency, and Drupal will enable it (and its own dependencies) automatically.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_norender -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_norender -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_norender -y
```

That's all it takes. There is no required configuration.

## Verify it worked

Edit a page that uses Layout Builder, hover over any component (block), and open
its contextual links. You should now see a **Publish / Unpublish** link. Toggling
it to unpublished should show the component on the preview with a red
"Unpublished" label and overlay, and hide it from the live rendered page.
