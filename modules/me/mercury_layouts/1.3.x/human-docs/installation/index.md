# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Layout Discovery** module (`layout_discovery`).
- The [**Style Options**](https://www.drupal.org/project/style_options) module
  (`style_options`), version **1.1.0 or newer**, which powers the per‑layout styling
  controls.
- On Drupal core older than 10.3 only, the **Single Directory Components** (SDC)
  module — on 10.3 and 11 SDC is part of core, so nothing extra is needed.
- To actually build pages with these layouts you will normally also have
  [**Mercury Editor**](https://www.drupal.org/project/mercury_editor) installed, since
  that is what consumes them.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/mercury_layouts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Style Options.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mercury_layouts -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mercury_layouts -y
```

Core's Layout Discovery and the Style Options module are enabled automatically as
dependencies.

## Verify it worked

Open your page‑building UI (typically Mercury Editor) and add a new section. The
**Mercury Stack**, **Mercury Two Columns**, and **Mercury Cluster** layouts should
now appear among the available layout choices, each offering style options you can
configure on the section.
