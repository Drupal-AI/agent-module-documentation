# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- A **Google Maps JavaScript API key** — not a Composer/PHP requirement, but the
  widget needs one to render the map. You can obtain one from Google's
  [Maps Embed API key documentation](https://developers.google.com/maps/documentation/embed/get-api-key).

There are no additional PHP libraries or module dependencies. This project is
covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/contactmap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/contactmap -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contactmap -y
```

## Verify it worked

The widget only appears once you fill in the settings form and the active theme
matches the configured theme. Go to
[Configuration](../configuration/index.md), enter your Google Maps API key, phone
number, address, and coordinates, save, then load a front‑end page and look for the
floating contact pin — click it to confirm the map, address, and click‑to‑call
phone link appear, and try dragging it around the screen.
