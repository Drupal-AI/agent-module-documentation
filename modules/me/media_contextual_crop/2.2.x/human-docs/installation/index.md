# Installation

## Requirements

- **Drupal core 11.4 or newer** (`core_version_requirement: ^11.4`). Drupal 10 is
  not supported on this branch — use 2.1.x for Drupal 10.
- The contrib **Crop API** module (`crop`) — Composer pulls it in as a dependency.
- Core's **Field** module (enabled on every standard site).
- A **core patch** that refactors `ImageStyleDownloadController` so the module's
  contextual download controller can reuse core's derivative token, scheme, and
  access checks. See the project page for the patch and apply it via
  `cweagans/composer-patches`.

The 2.x branch also relies on a **patch to the Crop API module**. If you hit an
`EntityStorageException: "'context' not found"`, make sure that patch is applied
(`composer reinstall drupal/crop`) and that the Crop database updates have run
(`drush updatedb`).

This API module does nothing on its own. To do any cropping you also need a family
module (Embed or Reference) and at least one crop adapter (Focal Point or Image
Widget Crop) — see the [main guide](../index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/media_contextual_crop -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including the Crop API module — as needed. Make sure the required
core and Crop patches are declared in your project's `composer.json` patches
section so they are applied on install.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_contextual_crop -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_contextual_crop -y
```

Enabling installs a database index on the Crop table to speed up context lookups.
The API alone has no visible effect — next, install and enable the family and
adapter modules you need.

## Verify it worked

Run `drush updatedb` to apply any pending updates, then
`drush pm:list --status=enabled | grep media_contextual_crop` to confirm the API
module is enabled. Check that both the core patch and the Crop API patch are
applied. The cropping interface itself shows up only once a family module and an
adapter are enabled and configured on a field's *Manage display*.
