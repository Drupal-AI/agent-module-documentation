# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Custom Elements** module (`custom_elements`) — required; it produces the
  custom‑element markup that this module delivers.
- The **Metatag** module (`metatag`) — required, so page metadata is included in
  the API payload.

Composer pulls in the required contrib modules for you when you require this one
with the `-W` flag below.

## Install with Composer

From the project root:

```bash
composer require drupal/lupus_ce_renderer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the Custom Elements and Metatag modules.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/lupus_ce_renderer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lupus_ce_renderer -y
```

Drupal enables the Custom Elements and Metatag dependencies automatically.

## Verify it worked

Request any existing page with the new format appended, for example:

```
https://your-site.example/node/1?_format=custom_elements
```

You should receive a **JSON** response containing the page's metadata and its
main content rendered as custom elements. If you get a normal HTML page instead,
confirm the module is enabled and clear caches with `drush cr`.

If you plan to build a complete decoupled stack rather than wiring the API up
yourself, consider installing
[Lupus Decoupled](https://www.drupal.org/project/lupus_decoupled), which builds
on this module and adds the CORS, menu, form, and view bridges a front end needs.
