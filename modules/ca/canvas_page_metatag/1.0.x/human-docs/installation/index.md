# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11.1`).
- The **Canvas** module (`drupal/canvas`) — the Experience Builder page builder.
- The **Metatag** module (`drupal/metatag`), including its Open Graph, Facebook,
  and Twitter Cards submodules, which provide the social‑sharing tags this module
  exposes to Canvas.

## Install with Composer

From the project root:

```bash
composer require drupal/canvas_page_metatag -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies (including Canvas and Metatag if they are not already present).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/canvas_page_metatag -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en canvas_page_metatag -y
```

Enabling it pulls in Canvas and Metatag (and the relevant Metatag submodules) as
dependencies if they are not already on. Once active, the meta‑tag fields are
available when you build a page in Canvas.
