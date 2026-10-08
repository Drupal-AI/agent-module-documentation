# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Module dependencies (Composer resolves the contrib ones automatically):
  - **Dimension** (`dimension`)
  - core **Options** (`options`), **Taxonomy** (`taxonomy`), and **Text** (`text`)
  - **Dynamic Entity Reference** (`dynamic_entity_reference`)
  - **Inline Entity Form** (`inline_entity_form`)
- A **platform integration** so the framework can actually talk to screens. The
  framework alone models the entities but has no vendor transport. Options include
  **signageOS** for production, plus example and custom platform submodules bundled
  with the framework for demos and API-less setups.
- Recommended companion modules: **Analog Digital Clock**
  (`analog_digital_clock`) and **Expose Actions** (`expose_actions`).

## Install with Composer

Installing with Composer is recommended so the dependencies are pulled in for you.
From the project root:

```bash
composer require drupal/digital_signage_framework -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/digital_signage_framework -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en digital_signage_framework -y
```

Then enable a platform integration — for example the bundled example platform to
try things out without real screens, or a production platform such as signageOS:

```bash
drush en digital_signage_example -y
```

## Verify it worked

After enabling, the settings page should be reachable at **Configuration →
Services → Digital Signage Framework**
(`/admin/config/services/digital_signage_framework`), and you should have the new
Device, Device type, Schedule, and Content setting entity types available. Next,
walk through the setup steps in order — see
[Configuration](../configuration/index.md).
