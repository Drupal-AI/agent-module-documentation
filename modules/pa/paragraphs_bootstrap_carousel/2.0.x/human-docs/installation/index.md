# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The [Paragraphs](https://www.drupal.org/project/paragraphs) module (`paragraphs`)
  enabled — this is the only module dependency.
- A **Bootstrap‑based theme** that loads Bootstrap's JavaScript. The `2.0.x` series
  is built for **Bootstrap 5** (it also works with Bootstrap 4, though the left/right
  controls may need a little custom CSS). The module does not bundle the Bootstrap
  library — your theme must provide it, or the carousel will not rotate.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_bootstrap_carousel -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_bootstrap_carousel -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_bootstrap_carousel -y
```

Enabling the module adds a new **Bootstrap carousel** paragraph type.

## Verify it worked

Go to **Structure → Paragraph types** (`/admin/structure/paragraphs_type`) and
confirm a **Bootstrap carousel** type is listed. Then add a Paragraphs field that
allows that type, set its display formatter to *Paragraph Bootstrap Carousel* and
map the image field, add a couple of slides, and view the page on your
Bootstrap‑themed front end — the slides should rotate.
