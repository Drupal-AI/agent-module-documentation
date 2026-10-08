# Installation

## Requirements

- **Drupal 10, 11 (or 12)** (`core_version_requirement: ^10||^11||^12`).

There are no module dependencies. jq_ui bundles a repaired copy of the jQuery UI
library, so there's nothing extra to download.

## Install with Composer

The module is designed as a **drop‑in replacement for the old `jquery_ui` module**,
using Composer's `replace` directive. From the project root:

```bash
composer require drupal/jq_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Because of the `replace` directive, Composer treats
`jq_ui` as satisfying anything that required `drupal/jquery_ui`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jq_ui -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module and rebuild caches

```bash
drush en jq_ui -y
drush cr
```

The cache rebuild (`drush cr`) makes Drupal pick up the newly provided asset
libraries.

## Individual library submodules

The 8.x branch also provides the individual jQuery UI asset libraries as separate
modules — Accordion, Autocomplete, Button, Checkboxradio, Controlgroup, Datepicker,
Dialog, Draggable, Droppable, Effects, Menu, Progressbar, Resizable, Selectable,
Selectmenu, Slider, Spinner, and Tooltip. Enable only the specific ones a module or
theme requires if you prefer a narrower footprint.

## Verify it worked

Because jq_ui is a utility module it has no visible UI of its own. The best check is
that a module or theme depending on jQuery UI now works — for example a jQuery UI
datepicker renders correctly. If you migrated from `jquery_ui`, confirm those
components still behave after enabling jq_ui and rebuilding caches.
