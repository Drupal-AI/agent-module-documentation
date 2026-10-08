# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **[Modifiers](https://www.drupal.org/project/modifiers)** module
  (`modifiers`) — the framework this plugs into.
- The **[Paragraphs](https://www.drupal.org/project/paragraphs)** module
  (`paragraphs`).
- Core **Options** (`options`).
- The **Vanta.js** JavaScript library (and its Three.js/p5 dependency). Version
  **0.5.21** is recommended. The module only attaches the library — you must
  install it yourself.

## Install with Composer

From the project root:

```bash
composer require drupal/modifiers_vanta -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including Modifiers and Paragraphs.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/modifiers_vanta -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Install the Vanta.js library

The animated backgrounds will not render until the Vanta.js library is present.
You have two options:

- **Manual:** download the Vanta.js library (version 0.5.21 recommended) and place
  the unpacked files in your site's `libraries/` folder (for example
  `libraries/vanta`).
- **Composer:** install the library via the package repository documented in the
  module's `README.md`.

## Enable the module

```bash
drush en modifiers_vanta -y
```

Enabling the module creates a new **Vanta Modifier** Paragraph bundle.

## Verify it worked

1. Confirm the **Vanta Modifier** paragraph bundle exists under **Structure →
   Paragraphs types** (`/admin/structure/paragraphs_type`).
2. Add a `field_modifiers` field to a block or paragraph, add a Vanta Modifier
   paragraph, pick an effect and colours, and save.
3. View the host component and confirm the animated background renders. If it does
   not, re-check that the Vanta.js library is installed correctly. See the
   [main guide](../index.md) for the configuration options.
