# Installation

## Requirements

- **Drupal 10.4 or newer, or Drupal 11** (`core_version_requirement: ^10.4 || ^11`).
- The **ECA** module (`eca`), version 2 or 3 (`^2 || ^3`).
- The **Metatag** module (`metatag`).
- An **ECA modeller** to build models visually — for example
  [ECA Modeller BPMN](https://www.drupal.org/project/bpmn_io) — which you enable
  separately.

Composer pulls in ECA and Metatag as dependencies. There are no third-party PHP
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/eca_metatag -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including ECA and Metatag — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eca_metatag -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it together with ECA (and add a modeller so you can build models):

```bash
drush en eca eca_metatag -y
```

Then enable an ECA modeller of your choice so you can create models in the UI.

## Next steps

There is no configuration page — the two actions this module provides are used
inside ECA models. See the "How to use it" section of the
[overview](../index.md) to add them to a model.

There are no submodules.
