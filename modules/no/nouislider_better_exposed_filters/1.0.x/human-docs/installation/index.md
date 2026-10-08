# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Better Exposed Filters** module
  (`better_exposed_filters:better_exposed_filters`) — a required dependency.
- The **noUiSlider** JavaScript library, **version 15.7.x or newer**, installed
  into `/libraries/nouislider` (see below).

Note that the release documented here is an early one (1.0.0‑alpha2), and the
project is minimally maintained (maintenance fixes only).

## Install the module with Composer

From the project root:

```bash
composer require drupal/nouislider_better_exposed_filters -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and will bring in Better Exposed Filters if it is not
already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/nouislider_better_exposed_filters -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Install the noUiSlider library

The module bundles the Drupal‑side glue but not the third‑party library itself.
Put noUiSlider (>= 15.7.x) into `/libraries/nouislider`. The recommended way is
via Composer, using the installers‑extender so npm‑asset packages land in
`/libraries`:

```bash
composer require oomphinc/composer-installers-extender npm-asset/nouislider
```

Alternatively, download noUiSlider manually and place its files in
`/libraries/nouislider`.

## Enable the module

```bash
drush en nouislider_better_exposed_filters -y
```

## Verify it worked

Edit a View that has an exposed **multi‑value select** filter, open its **Better
Exposed Filters** settings, and confirm the **NoUiSlider** widget now appears as
an option for that filter. Choose it, pick a Pips mode, save, and view the
page — the filter should render as a draggable slider. If the widget option is
missing, re‑check that Better Exposed Filters is enabled; if the option appears
but no slider renders, re‑check that the noUiSlider library is present in
`/libraries/nouislider`.
