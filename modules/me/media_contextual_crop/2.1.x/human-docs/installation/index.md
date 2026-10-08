# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The contrib **Crop API** module (`crop`) — Composer pulls it in as a
  dependency.
- Core's **Field** module (enabled on every standard site).

Note the 2.x branch relies on a **patch applied to the Crop API module**. If you
hit an `EntityStorageException: "'context' not found"`, make sure the patch is
applied (`composer reinstall drupal/crop`) and that the Crop database updates have
run (`drush updatedb`) — see the project page for details.

This API module does nothing on its own. To do any cropping you also need a
family module (Embed or Reference) and at least one crop adapter (Focal Point or
Image Widget Crop) — see the [main guide](../index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/media_contextual_crop -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including the Crop API module — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_contextual_crop -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_contextual_crop -y
```

Enabling the API alone has no visible effect. Next, install and enable the family
and adapter modules you need (for example
`composer require drupal/media_contextual_crop_iwc_adapter -W` and
`drush en media_contextual_crop_iwc_adapter -y`).

## Verify it worked

Run `drush pm:list --status=enabled | grep media_contextual_crop` and confirm the
API module is enabled, then check that the Crop API patch is applied and its
database updates have run (`drush updatedb`). The cropping interface itself shows
up only once a family module and an adapter are enabled and configured on a
field's *Manage display*.
