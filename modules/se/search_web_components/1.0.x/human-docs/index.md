# Search Web Components — manual setup guide

**Search Web Components** (`search_web_components`) is a library of modern,
client-side search widgets — a search box, a results list, facets, a sort
control, a pager and more — that you drop onto a Drupal page and wire up to a
search endpoint. The widgets are built as Lit "web components" (standard custom
HTML elements), so once they are on the page they talk directly to a JSON search
endpoint in the browser and update instantly as the visitor types or filters,
without a page reload.

The problem it solves is the familiar pain of building a decent search page with
Views and Ajax, where every keystroke or facet click has to round-trip to
Drupal to re-render HTML. Here, Drupal only serves the initial page; the search
interaction happens in the browser against a **Decoupled Search API** endpoint.
That is why the module depends on the **Search API Decoupled**
(`search_api_decoupled`) module — you build and index your content with Search
API as usual, expose a decoupled endpoint, and the components render against it.

This module does **not** work the moment you enable it — it needs some setup:
you enable it (and Search API Decoupled), create and configure a Search API
index, create a decoupled Search API endpoint, tune the search settings on that
endpoint (sort options, page sizes, display modes, and which component renders
which kind of result), then place the component blocks on a page. Three optional
submodules make this easier: **Search Web Components: Block**
(`search_web_components_block`) exposes each component as a placeable block in a
"Search Components" category, **Search Web Components: Facets**
(`search_web_components_facets`) adds facet widgets and serves facet data in the
endpoint response, and **Search Web Components: Layout**
(`search_web_components_layout`) ships one- and two-column Layout Builder layouts
pre-wired for search regions.

This guide is written for a **human** setting things up through the admin UI. If
you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its dependency, and pick the submodules you need.
2. [Configuration](configuration/index.md) — configure the decoupled endpoint's
   search settings and place the component blocks on a page.

## Where it lives in the admin menu

The module has no single settings page of its own. Its configuration lives on
each **Search API endpoint** you create, under **Configuration → Search and
metadata → Search API Endpoints**
(`/admin/config/search/search-api/endpoints`). Opening an endpoint's edit form
reveals the added "Search Web Components" settings. All of these admin surfaces
are gated by the **Administer search api endpoint** permission, so only trusted
administrators can change them.

## How to use it

Once the module is set up, you surface search on a page in one of two ways. With
the **Block** submodule enabled, each component (search box, results, facets,
sort, pager, applied-facets, results switcher, and so on) appears as a block you
place through **Structure → Block layout** or Layout Builder. Alternatively, the
components can be embedded directly in a Twig template — you just need to attach
the `search_web_components/components` library and wrap the components in the
provided container element. The **Layout** submodule's search layouts handle that
wiring for you.
