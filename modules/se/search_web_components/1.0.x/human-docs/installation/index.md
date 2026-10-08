# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Search API Decoupled** module (`search_api_decoupled`) — this is a hard
  dependency and provides the JSON search endpoint the components consume. It in
  turn builds on Search API, so you will have Search API installed as part of
  this stack.
- A working **Search API index** over the content you want to search.

There are no extra PHP or third-party library requirements for this module
itself. The component JavaScript ships with the module (a compiled Lit bundle,
about 60 kB), so there is no separate frontend build to run.

## Install with Composer

From the project root:

```bash
composer require drupal/search_web_components -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Search API
Decoupled and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/search_web_components -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_web_components -y
```

Enabling it will also enable Search API Decoupled if it is not already on. Note
that, unlike a drop-in module, this one does nothing visible until you configure
an endpoint and place the components — see
[Configuration](../configuration/index.md).

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Block** | `search_web_components_block` | Exposes each component as a placeable Drupal block (search box, results, facets, sort, pager, applied facets, results switcher and more) in a "Search Components" category, so you can place them via Block layout or Layout Builder. This is the easiest way to build a search page. |
| **Facets** | `search_web_components_facets` | Adds SWC facet widgets (dropdown, dropdown-html, button, checkbox) and a second subscriber that builds facet data (counts, active values, hierarchy) into the endpoint response, plus a reorganized facet edit form. |
| **Layout** | `search_web_components_layout` | Provides one- and two-column Layout Builder layouts pre-wired for search regions — they attach the components library and wrap blocks in the required container for you. |

For the typical block-based workflow, enable the Block submodule:

```bash
drush en search_web_components_block -y
```

## Verify it worked

After enabling, go to **Configuration → Search and metadata → Search API
Endpoints** (`/admin/config/search/search-api/endpoints`) and confirm you can
create an endpoint. If you enabled the Block submodule, open **Structure → Block
layout** and confirm a "Search Components" category of blocks is available to
place. From there, continue with [Configuration](../configuration/index.md).
