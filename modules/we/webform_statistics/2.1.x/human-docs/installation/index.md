# Installation

## Requirements

Webform Statistics needs:

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Webform** module (`drupal/webform` `^6.2`) — the forms it reports on.
- Core's **Views** module — enabled automatically as a dependency.

There are no third-party PHP libraries to install. The D3 charting library (v7)
is loaded at runtime from the jsDelivr CDN, so charts require the visitor's
browser to be able to reach that CDN; the statistics tables themselves work
without it.

## Install with Composer

From the project root:

```bash
composer require drupal/webform_statistics -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update
Webform and other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/webform_statistics -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webform_statistics -y
```

Enabling the module installs the `webform_statistics` View and adds the
**Statistics** tabs to the webform submissions screen. There is no configuration
step.

## Verify it worked

Log in as a user with the **Administer webform submission** permission and go to
**Structure → Webforms → Submissions**
(`/admin/structure/webform/submissions/statistics`). You should see a new
**Statistics** tab, plus **By day / week / month** breakdowns. See the
[overview](../index.md) for how to use the filters, charts, and reusable Views
pieces.
