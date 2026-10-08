# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **User** module (`user`), always present.
- The [Chosen](https://www.drupal.org/project/chosen) module (`chosen:chosen`) and
  its JavaScript library, used for the module's select controls.
- Network access to the **HAL API** over HTTPS.

There are no additional PHP library requirements to add by hand.

## Install with Composer

From the project root:

```bash
composer require drupal/hal_publications -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Chosen
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/hal_publications -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hal_publications -y
```

This also enables the Chosen dependency if it isn't already on. You may still need
to install the Chosen JavaScript library per that module's instructions.

## Verify it worked

1. Configure the portals and collections you want to query — see
   [Configuration](../configuration/index.md).
2. Create a **Hal Author** entity (or import your author data).
3. Place a HAL Publications **block** via **Structure → Block layout**, choose a
   sort option, and view the page.
4. Confirm publications load from HAL and render with your chosen citation style.
   If nothing appears, re-check the portal/collection settings and the API timeout.
