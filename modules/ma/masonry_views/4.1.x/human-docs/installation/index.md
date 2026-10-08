# Installation

## Requirements

Masonry Views is the Views bridge for the Masonry layout system, so it depends on
both Views and the Masonry module. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) enabled — it ships with Drupal and is enabled
  automatically as a dependency.
- The **Masonry** module (`drupal/masonry`, `^4.0`), which provides the layout
  options and the jQuery Masonry integration. Composer installs it for you.
- The **jQuery Masonry library** itself, which the Masonry module uses to do the
  actual layout. Without the library, the Masonry format's options are disabled and
  no layout is applied — see the Masonry module's own documentation for how to add
  the library.

There are no PHP library requirements from this module directly.

## Install with Composer

From the project root:

```bash
composer require drupal/masonry_views -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Masonry module
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/masonry_views -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en masonry_views -y
```

Enabling it also turns on Views and the Masonry module. Make sure the jQuery Masonry
library is installed (as the Masonry module requires) so the layout actually renders.

## Verify it worked

Edit any view, open its **Format** setting, and confirm **Masonry** appears as a
choice. Select it, set a couple of options, save, and view the display — the results
should pack into a cascading grid. See the [overview](../index.md#how-to-use-it) for
the step‑by‑step, and the Masonry module's documentation for the meaning of each
layout option.
