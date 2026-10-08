# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Acquia CMS Common** (`acquia_cms_common`) — the shared Acquia CMS layer.
- The **Site Studio / Cohesion** modules: `cohesion_base_styles`,
  `cohesion_custom_styles`, `cohesion_elements`, `cohesion_style_helpers`,
  `cohesion_sync`, `cohesion_website_settings`, and `sitestudio_page_builder`.
- **Collapsiblock** (`collapsiblock`) and core **Media Library**
  (`media_library`).
- A valid **Acquia Site Studio license and API key** — Site Studio is a
  proprietary product, and its modules and functionality require it. Without the
  license the Cohesion dependencies cannot be installed or used.

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_cms_site_studio -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Cohesion/Site
Studio modules and the other shared dependencies. Note that access to the Site
Studio packages depends on your Acquia subscription.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/acquia_cms_site_studio -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acquia_cms_site_studio -y
```

Drush enables the dependencies automatically. The module is enabled at this point,
but Site Studio is not usable until you enter the API key and import its packages —
continue to [Configuration](../configuration/index.md).
