# Installation

## Requirements

- **Drupal 10, 11 or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **Field** (`field`) and **Inline Form Errors** (`inline_form_errors`)
  modules, both part of a standard Drupal install.
- The **Color Field** module (`drupal/color_field`), which Composer installs
  automatically as a dependency — it is used by the optional routeplanner submodule.
- A **Mapy.com API key** — the maps use the Mapy.com REST API, so you need a key from
  Mapy.com to display maps. See [Configuration](../configuration/index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/mapycom -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (including Color Field) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mapycom -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mapycom -y
```

The base module gives you the map field, widget, formatters and Views style. Two
optional submodules ship alongside it — enable them only if you need them:

```bash
# Webform location elements (needs the Webform module):
drush en mapycom_webform -y

# Route drawing:
drush en routeplanner -y
```

## Verify it worked

At **Extend** (`/admin/modules`) confirm **Mapy.com** is checked. Then go to
**Configuration → Web services → Mapy.com** (`/admin/config/services/mapycom`) to
enter your API key — see [Configuration](../configuration/index.md) for the full
walkthrough and for how to add the map field to your content. Until a key is saved,
map areas display a "service unavailable" placeholder and the **Status report**
(`/admin/reports/status`) shows a warning.
