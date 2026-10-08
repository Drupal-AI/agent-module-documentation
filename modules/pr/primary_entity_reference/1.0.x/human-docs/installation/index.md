# Installation

## Requirements

- **Drupal 11.1 or newer** (`core_version_requirement: >=11.1`).
- No other modules and no third‑party libraries are required. It builds on core's
  Field and Entity Reference APIs. (It also integrates with **Inline Entity Form**
  if you use it, but that is optional.)

Note this release is a **beta** (`1.0.0-beta8`) — review it before relying on it in
production.

## Install with Composer

From the project root:

```bash
composer require drupal/primary_entity_reference -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/primary_entity_reference -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en primary_entity_reference -y
```

## Verify it worked

After enabling, add a field to any content type and confirm **Primary Entity
Reference** appears in the list of field types. Add a couple of referenced values,
mark one as primary with the module's widget, and confirm the "primary only"
formatter shows just that entity on the rendered display. See
[How to use it](../index.md#how-to-use-it) for the full walkthrough.
