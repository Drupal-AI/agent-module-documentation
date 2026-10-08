# Search API Spellcheck — manual setup guide

**Search API Spellcheck** (`search_api_spellcheck`) adds a Google‑style *"Did you
mean:"* correction and a list of alternative keyword spellings to a Search API search
page. When a visitor mistypes a query — "jawa class lording" instead of "java class
loading" — the module turns the search backend's own spellcheck data into a clickable
link that re‑runs the search with the corrected phrase, so shoppers and readers still
find what they were after instead of hitting a dead end.

It works by providing two Views **area handlers** — small blocks you drop into the
**Header** or **Footer** of a Search API view:

- **"Did You Mean"** shows a single best‑guess correction link.
- **"Suggestions"** lists every keyword variation as a bulleted list of links.

There is no settings page, no service, and no Drush command — everything is configured
right inside the Views UI when you add one of these handlers to a view. Each correction
link re‑runs the same view with the fixed phrase placed into the exposed fulltext
filter, keeping the visitor's other query parameters (facets, sort) intact.

One important caveat: the whole feature depends on **spellcheck data coming from the
search backend**, so it only works on a backend that supports it — notably **Apache
Solr** (via `search_api_solr`). On a backend that does not advertise the
`search_api_spellcheck` feature, such as the core **Database** server, the handlers
simply render nothing. The module requires **Drupal 10.1+ or 11**, the **Search API**
module (`~1.35`), and core's **Views**.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — add a "Did You Mean" or "Suggestions" area
   to a Search API view and set its options.

## Where it lives in the admin menu

Search API Spellcheck adds no admin page of its own. You configure it entirely from the
**Views** editor (**Structure → Views**, `/admin/structure/views`) by adding one of its
area handlers to a Search API search view's Header or Footer.

## How to use it

Once the module is enabled and you are running a compatible backend (Solr), edit your
Search API search view, add the **Search API Spellcheck "Did You Mean"** handler to the
**Header** (and/or the **"Suggestions"** handler to the **Footer**), and save. The
correction prompt then appears automatically whenever the backend returns spellcheck
data for the visitor's query. The output is themeable — see the sibling `agent/` docs
for the theme hooks and templates if you want to restyle it. Step‑by‑step setup and the
available options are in [Configuration](configuration/index.md).
