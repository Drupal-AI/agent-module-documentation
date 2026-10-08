# Installation

## Requirements

- **Drupal 8, 9, 10, 11, or 12** (`core_version_requirement:
  ^8 || ^9 || ^10 || ^11 || ^12`).
- No other Drupal module, Composer, or PHP library dependencies. It uses core's
  built‑in Filter (text format) system, which is always available.

## Install with Composer

From the project root:

```bash
composer require drupal/data_hover_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/data_hover_filter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en data_hover_filter -y
```

Enabling the module makes the filter *available*, but it does nothing until you
switch it on for a text format. Do that next at **Configuration → Content
authoring → Text formats and editors** — see "How to use it" on the
[overview page](../index.md).

## Verify it worked

After enabling the filter on a text format, create or edit a piece of content
that uses that format, add a link, and save. View the rendered page and inspect
the link's HTML — the anchor tag should now include a `data-hover` attribute set
to the link text.
