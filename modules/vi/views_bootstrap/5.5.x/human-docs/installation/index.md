# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- Core's **Views** module (`views`) enabled — this is the only module dependency,
  and Drupal enables it automatically.
- A **Bootstrap 5 theme** (or the Bootstrap 5 CSS/JS framework) active on your
  site. The module produces Bootstrap markup but relies on your theme to supply
  the actual styling and the interactive behaviors (carousel, accordion, tabs).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_bootstrap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_bootstrap -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_bootstrap -y
```

The new Bootstrap styles appear immediately in the Views UI. There are no
submodules to consider and no required configuration — the styles are selected
per view.

## Verify it worked

Go to **Structure → Views**, edit any view, and open the **Format** setting for a
display. You should see the Bootstrap styles (Cards, Carousel, Accordion, Tab,
Grid, and so on) listed as options. Pick one and configure it as described in
[Configuration](../configuration/index.md). Remember that the visual result
depends on a Bootstrap 5 theme being active.
