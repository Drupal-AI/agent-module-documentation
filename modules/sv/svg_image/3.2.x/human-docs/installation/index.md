# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Image** module (`image`) — this is a dependency and Drupal enables it
  automatically.
- The **`enshrined/svg-sanitize`** PHP library (version `>=0.22 <1.0`), used to
  strip unsafe content from inlined SVGs. Installing the module with Composer, as
  below, pulls this library in automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/svg_image -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — and, importantly here, installs the required
`enshrined/svg-sanitize` sanitizer library alongside the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/svg_image -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en svg_image -y
```

Enabling the module does not, on its own, make any field accept SVGs — it swaps
in the SVG‑aware widget and formatters, but you still need to allow the `svg`
extension on each field where you want it. See
[Configuration](../configuration/index.md).

## Submodule — optional

**SVG Image Responsive** (`svg_image_responsive`) adds SVG support to core's
Responsive image formatter. Enable it only if you use responsive image styles:

```bash
drush en svg_image_responsive -y
```

It requires the base SVG image module, which is already present once you have
installed it above.
