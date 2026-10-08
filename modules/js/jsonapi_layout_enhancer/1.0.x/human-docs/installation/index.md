# Installation

## Requirements

- **Drupal 9.2 or 10** (`core_version_requirement: ^9.2 || ^10`).
- Core's **Layout Builder** (`layout_builder`) and **JSON:API** (`jsonapi`)
  modules.
- The contributed **JSON:API Extras** module (`jsonapi_extras`), which provides
  the resource-override UI and the normalization the enhancer relies on.
- A **core JSON:API patch** so that the `layout_builder__layout` key is emitted in
  JSON:API output — see the module's project page for the issue and the patch that
  matches your Drupal version.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_layout_enhancer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including JSON:API Extras — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_layout_enhancer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_layout_enhancer -y
```

Drupal enables Layout Builder, JSON:API, and JSON:API Extras as dependencies if
they are not already on.

## Verify it worked

1. Apply the core JSON:API patch noted above so the layout field is serialized.
2. In JSON:API Extras, at `/admin/config/services/jsonapi/resource_types`,
   override the resource for a content type that uses Layout Builder and enable
   the **layout** field enhancer on its layout field.
3. Create a node with Layout Builder, place a custom block in the layout, give it
   a URL alias (for example `new-page`), and fetch `/jsonapi/page/en/new-page`.

You should be redirected to the node's canonical JSON:API URL and see each placed
block's data inlined under `block_content_data`.
