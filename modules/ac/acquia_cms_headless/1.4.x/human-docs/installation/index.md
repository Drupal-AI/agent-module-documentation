# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The decoupled stack it configures, all pulled in by Composer:
  `acquia_cms_common`, `acquia_cms_tour`, **Consumers** (`consumers`), **JSON:API
  Extras** (`jsonapi_extras`), **JSON:API Menu Items** (`jsonapi_menu_items`),
  **Next.js JSON:API** (`next_jsonapi`), **OpenAPI JSON:API**
  (`openapi_jsonapi`), **OpenAPI UI ReDoc** (`openapi_ui_redoc`), **OpenAPI UI
  Swagger** (`openapi_ui_swagger`), core **REST** (`rest`), and **Simple OAuth**
  (`simple_oauth`).
- Because it depends on `acquia_cms_common`, it expects the broader Acquia CMS
  ecosystem to be present.

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_cms_headless -W
```

The `-W` (`--with-all-dependencies`) flag is important — the headless stack is a
wide dependency tree, and `-W` lets Composer pull in and align all of it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/acquia_cms_headless -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acquia_cms_headless -y
```

Drush enables the full stack automatically.

## Optional: the Headless UI dashboard

To get the admin dashboard for managing headless settings, consumers, and tokens,
enable the submodule:

```bash
drush en acquia_cms_headless_ui -y
```

This is recommended if you want to manage the headless setup through the UI rather
than only through Drush and the individual module screens.

## Next steps

The module is enabled, but a headless site needs its OAuth keys, consumers, and
JSON:API exposure configured before a front end can talk to it. Continue to
[Configuration](../configuration/index.md).
