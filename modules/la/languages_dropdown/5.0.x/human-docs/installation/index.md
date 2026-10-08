# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Language** module (`language`) enabled, with **two or more languages**
  configured.
- The **Bootstrap Languages** front‑end library, downloaded and extracted to
  `/libraries/bootstrap-languages` in your project. The module uses this library
  to render the flags and the dropdown styling, so it must be present.

## Install with Composer

From the project root:

```bash
composer require drupal/languages_dropdown -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/languages_dropdown -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Add the Bootstrap Languages library

Download the Bootstrap Languages library and extract it so that it lives at:

```
/libraries/bootstrap-languages
```

(relative to your Drupal web root). Without this library the dropdown will not
render its flags/styling correctly.

## Enable the module

```bash
drush en languages_dropdown -y
```

No configuration is strictly required to get a working dropdown — the remaining
work is placing the block. See [Configuration](../configuration/index.md).

## Verify it worked

Place the **Languages Dropdown (Bootstrap)** block in a visible region under
**Structure → Block layout**, then view the site as a visitor. The language
switcher should appear as a single dropdown showing flags and/or language labels,
rather than a list of links.
