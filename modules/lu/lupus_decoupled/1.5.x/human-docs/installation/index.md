# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The suite builds on the **Lupus Custom Elements Renderer**
  (`lupus_ce_renderer`) and the **Custom Elements** module; Composer resolves
  these for you.
- A **Nuxt.js front end** to consume the API. The project ships a starter, demo
  setups, and a project template (with DDEV and Gitpod support) — see
  [lupus-decoupled.org](https://lupus-decoupled.org/).

Enabling the top‑level module automatically pulls in three required submodules:
`lupus_decoupled_ce_api`, `lupus_decoupled_cors`, and `lupus_decoupled_menu`.

## Install with Composer

From the project root:

```bash
composer require drupal/lupus_decoupled -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. For a faster start, the project also provides
**base recipes** and a project template that scaffold a working Drupal + Nuxt
stack.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/lupus_decoupled -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lupus_decoupled -y
```

This enables the base module and its three required submodules.

## Submodules — enable only what you need

Beyond the three required submodules, the suite offers bridges for the parts of
Drupal that are awkward in a decoupled build. Enable the ones your front end
needs:

| Submodule | Machine name | What it bridges |
|-----------|--------------|-----------------|
| **CE API** (required) | `lupus_decoupled_ce_api` | The custom‑elements API itself. |
| **CORS** (required) | `lupus_decoupled_cors` | Cross‑origin request configuration for your front‑end origin. |
| **Menu** (required) | `lupus_decoupled_menu` | Exposes Drupal menus to the front end. |
| **Form** | `lupus_decoupled_form` | Drupal forms. |
| **User form** | `lupus_decoupled_user_form` | User account / login forms. |
| **Webform** | `lupus_decoupled_webform` | Webform submissions. |
| **Contact** | `lupus_decoupled_contact` | Contact forms. |
| **Views** | `lupus_decoupled_views` | Renders a View through the API. |
| **Block** | `lupus_decoupled_block` | Exposes blocks. |
| **Layout Builder** | `lupus_decoupled_layout_builder` | Layout Builder layouts. |
| **Canvas** | `lupus_decoupled_canvas` | Drupal Canvas integration. |
| **Schema Metatag** | `lupus_decoupled_schema_metatag` | schema.org structured metadata. |
| **Site info** | `lupus_decoupled_site_info` | Site information for the front end. |
| **Responsive preview** | `lupus_decoupled_responsive_preview` | Responsive previewing. |
| **API log** | `lupus_decoupled_api_log` | Logs what the front end requested (useful while developing). |

For example, to add form and Views support:

```bash
drush en lupus_decoupled_form lupus_decoupled_views -y
```

## A note on the file URL generator

The `lupus_decoupled_ce_api` submodule **replaces the core `file_url_generator`
service** with its own implementation of the same interface. If another module on
your site type‑hints the *concrete* `Drupal\Core\File\FileUrlGenerator` class
rather than the interface, it will fatal after installation. If something breaks
right after adopting the suite, check for a concrete type hint on that service
first.

## Verify it worked

Request a page through the custom‑elements API — Lupus Decoupled exposes it via a
`/ce-api/` prefix, for example `/ce-api/node/1`. You should receive a JSON
response carrying the page's metadata and its content as custom elements. From
there, stand up the Nuxt front end (the project's starter or template is the
fastest route) and point it at your Drupal API.
