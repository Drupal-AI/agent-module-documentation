# Installation

## Requirements

Facets needs **Drupal 10.1+ or 11** (`^10.1 || ^11`). Its `.info.yml` declares no
hard module dependency, but in practice a facet does nothing on its own — it
filters a **Search API** index, so you need:

- **Search API** (`search_api`) — the framework that provides the search index a
  facet attaches to. If you have not set it up yet, follow the sibling
  [Search API manual setup guide](../../../../search_api/1.41.x/human-docs/index.md)
  first: install it, create a **server** and an **index**, add the fields you want
  to facet on, and index your content.

Optional extras (suggested by the module, not required to install):

- **Better Exposed Filters** (`better_exposed_filters`) — needed for AJAX support
  when facets are rendered as views exposed filters.
- **jQuery UI Slider** / **jQuery UI Touch Punch** — needed by the *Facets Range
  Widget* submodule.

Facets also ships several submodules (Facets Exposed Filters, Facets Range Widget,
Facets REST, Facets Searchbox Widget, Facets Summary, Facets Demo). They are
documented separately; you do not need any of them for a basic facet.

## Install with Composer

From the project root:

```bash
composer require drupal/facets -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update related
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/facets -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en facets -y
```

Once enabled, the Facets screens appear under **Configuration → Search and
metadata → Facets** (`/admin/config/search/facets`).

## Verify it worked

Log in as an administrator and go to `/admin/config/search/facets`. You should see
the **Facets** list page with a **+ Add facet** button. The list will be empty
until you create facets — and, as the next sections explain, you first need a
Search API index to act as the **facet source**.

Next, review the [Configuration](../configuration/index.md) page to understand the
facet-source prerequisite, then [create your first facet](../creating-a-facet/index.md).
