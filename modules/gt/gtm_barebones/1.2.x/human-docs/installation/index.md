# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.2** or newer — this is a hard requirement for this module.
- A **Google Tag Manager container** and its ID (`GTM-XXXXXXX`).
- Optionally, a **Content‑Security‑Policy** module — if one is installed, Barebones
  GTM integrates with it automatically.

There are no other Drupal module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/gtm_barebones -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gtm_barebones -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gtm_barebones -y
```

After enabling, set your GTM container ID as described in the module's `README.md`
(see the note in the [overview](../index.md#configuration)).

## Verify it worked

Once the container ID is set, load any front‑end page and view its source: you
should see the Google Tag Manager container snippet in the markup, referencing
your `GTM-XXXXXXX` ID. Confirm the scripts load from Google's domain in your
browser's network tab.
