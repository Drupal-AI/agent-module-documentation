# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Core's **Field** module (`field`) enabled — the only dependency, and part of Drupal core
  (on by default on virtually every site).
- No SoundCloud API key is needed. Note, though, that the **Default (PHP-based)** formatter
  needs the web server to make an outbound request to soundcloud.com when rendering, and the
  **Javascript** formatter needs the visitor's browser to reach the SoundCloud CDN.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/soundcloudfield -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/soundcloudfield -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en soundcloudfield -y
```

Once enabled, **SoundCloud** appears as a field type wherever you add fields. There is no
settings page — see the [main page](../index.md#how-to-use-it) for how to add the field, pick
the widget, and choose a display formatter.
