# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- The base [Mapbox](https://www.drupal.org/project/mapbox) module (`mapbox`) — a
  required dependency that holds the access token and default style. Composer pulls
  it in with the `-W` flag below.
- Core's **Field** module (`field`), enabled automatically as a dependency.
- A **Mapbox account** and access token, configured on the base module (see its
  own guide).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/mapbox_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the required base
**Mapbox** module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mapbox_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mapbox_field -y
```

This also enables the base **Mapbox** module if it isn't on already.

## Set the token on the base module first

Before the field will render maps, configure the access token and default style on
the **base Mapbox module** at **Configuration → Web services → Mapbox**
(`/admin/config/services/mapbox`). Mapbox Field reads both from there; without a
token, the widget shows a "missing access token" message.

## Verify it worked

Add a **Mapbox Field** to a content type (**Structure → Content types → *(your
type)* → Manage fields**), set the **Mapbox** widget on **Manage form display**,
and open a content edit form — the interactive map picker should appear. See the
[overview](../index.md#how-to-use-it) for the full field setup.
