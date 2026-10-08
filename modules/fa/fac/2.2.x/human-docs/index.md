# Fast Autocomplete — manual setup guide

**Fast Autocomplete** (`fac`, "Fast Autocomplete") shows IMDB‑style suggestions
underneath a text input as the visitor types — a typeahead search box. Its trick is
speed: instead of hitting Drupal on every keystroke, suggestions are served from
pre‑generated **static JSON files** in the public files directory, so a repeated
query is answered by the web server directly without a full Drupal bootstrap. The
first time a particular query runs, Drupal generates the results and saves the JSON
file; every later request for the same query is served straight from that file.

You attach autocomplete to any input on your site by **CSS/jQuery selector** (for
example `input.form-search`), so it works with your existing search box rather than
forcing a widget on you. Each **Fast Autocomplete configuration** you create picks a
**search backend** — a simple published‑node‑title match, or a Search API index for
richer search — and controls how suggestions look and behave: how many to show, a
minimum and maximum key length, a viewport breakpoint so it can stay off on mobile,
keyword highlighting, a "view all results" link, and custom HTML shown when the box
is focused but empty. Each suggestion can be rendered with a **view mode**, so results
look like teasers instead of plain text.

Because results are cached in public files, the module is careful about access:
by default it runs the search **as the anonymous user**, so restricted content can
never leak into the public cache. (You can opt into searching as the current user,
in which case the cache path includes a rotating role‑based hash so users only ever
see cache built for their own roles.) Optional cron cleanup deletes stale JSON files,
and a Drush command purges them on demand.

Developers can add their own search backends through the `fac_search` plugin type and
customize the empty‑box content with `hook_fac_empty_result_alter()`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — general settings and building a Fast
   Autocomplete configuration, field by field.

## Where it lives in the admin menu

Its configurations are managed at **Configuration → Search and metadata → Fast
Autocomplete** (`/admin/config/search/fac`), with a small general settings form at
`/admin/config/search/fac/settings`.

## How to use it

1. Install and enable the module.
2. Create a **Fast Autocomplete configuration**, point it at your input's selector,
   and choose a search backend.
3. Tune how many results appear, whether keywords are highlighted, and what shows on
   an empty box.
4. Load the page with that input and start typing — suggestions appear beneath it.

The full walkthrough is in [Configuration](configuration/index.md).
