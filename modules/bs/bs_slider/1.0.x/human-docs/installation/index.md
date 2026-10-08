# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- No third-party Composer or PHP library requirements for the base module. Each
  library submodule pulls in the assets it needs for its slider library.

## Install with Composer

From the project root:

```bash
composer require drupal/bs_slider -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bs_slider -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module first:

```bash
drush en bs_slider -y
```

## Submodules — enable a library and a source

BS Slider is designed to be used together with its submodules. Enable at least
one *library* submodule and one *source* submodule for the combination you want:

| Submodule | Machine name | Role |
|-----------|--------------|------|
| Bootstrap | `bs_slider_bootstrap` | Library — render with Bootstrap |
| Swiper | `bs_slider_swiper` | Library — render with Swiper |
| Tiny Slider | `bs_slider_tiny_slider` | Library — render with Tiny Slider |
| Paragraphs | `bs_slider_paragraphs` | Source — slides from Paragraphs |
| Entity reference revisions | `bs_slider_entity_reference_revision` | Source — slides from referenced entity revisions |
| Views | `bs_slider_views` | Source — slides from a View |

For example:

```bash
drush en bs_slider_swiper bs_slider_views -y
```

Each submodule requires the base `bs_slider` module, which is already present
once you have installed it above.
