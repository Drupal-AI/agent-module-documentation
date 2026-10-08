# Installation

## Requirements

Simple Google Maps needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Field** (`field`) and **Text** (`text`) modules enabled. These are part
  of Drupal core and are enabled automatically as dependencies.
- For the **static map image** only, a **Google Maps API key**. The dynamic iframe
  map and the map link work without one.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_gmap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_gmap -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_gmap -y
```

There is no required configuration and no settings form of its own — you use the
module by choosing its formatter on a text field's display.

## Submodules

Simple Google Maps ships **no submodules**.

## Verify it worked

Go to a content type that has a plain Text field, open its **Manage display** page
(*Structure → Content types → (a type) → Manage display*), and open the format
dropdown for that field. You should see **Google Map from one‑line address** as an
option.
