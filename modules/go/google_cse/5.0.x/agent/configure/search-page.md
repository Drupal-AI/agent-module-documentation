<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# google_cse — configure the search page

Google Programmable Search has **no settings object and no admin form of its own**. Its
configuration is the **plugin configuration of a core Search page** — a `search.page.<id>`
config entity whose `plugin` is `google_cse_search`. All options live under that entity's
`configuration:` map (config schema `search.plugin.google_cse_search`).

Create/edit through the UI at **`/admin/config/search/pages`** (route
`entity.search_page.add_form` / `entity.search_page.edit_form`), "Add search page" →
plugin "Google Programmable Search". Or manage it directly as config (below).

## configuration keys (defaults from `GoogleSearch::defaultConfiguration()`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `cx` | string | `''` | **Search Engine ID** from Google (e.g. `012345678:abcde`). Required in the form. |
| `results_display` | string | `here` | `here` = render results on this site (needs JS); `google` = redirect the box to `https://cse.google.com/cse`. |
| `custom_results_display` | string | `results-only` | Google layout: `overlay`, `full-width`, `two-column`, `compact`, `results-only`, `google-hosted`. |
| `display_drupal_search` | bool | `true` | Show the Drupal-provided search input vs Google's own input. |
| `results_accessibility` | bool | `true` | Add `role="status"` to the results summary (only when `results_display: here`). |
| `watermark` | bool | `false` | Show the Google watermark (branding). |
| `query_key` | string | `keys` | Query-string parameter that carries the search terms. |
| `results_searchbox_width` | int | `40` | Search input width in characters. |
| `results_prefix` | text | `''` | HTML shown before results. |
| `results_suffix` | text | `''` | HTML shown after results. |
| `custom_css` | string | `''` | URL of an external stylesheet to load for the results. |
| `data_attributes` | sequence | `[]` | List of `{key, value}` pairs mapped to Google Programmable Search element attributes (e.g. `data-gl`, `data-lr`, `data-cr`, `data-as_sitesearch`, `data-safeSearch`). |

The entity also carries the standard core Search page fields: `id`, `label`, `path` (the
search route suffix under `/search/`), `plugin: google_cse_search`, `weight`, `status`.

## drush / PHP recipes

Read the cx and options of an existing google search page:

```bash
drush cget search.page.<id> configuration
```

Create a Google Programmable Search page from scratch (PHP; also rebuilds the search
routes via the module's `hook_entity_insert`):

```bash
drush php:eval '
use Drupal\search\Entity\SearchPage;
SearchPage::create([
  "id" => "google_search",
  "label" => "Google Programmable Search",
  "path" => "google",
  "plugin" => "google_cse_search",
  "configuration" => [
    "cx" => "012345678:demo_engine",
    "results_display" => "here",
    "custom_results_display" => "results-only",
  ],
])->save();
'
```

Update a single option on an existing page (config API preserves the rest):

```bash
drush cset search.page.google_search configuration.watermark true -y
drush cset search.page.google_search configuration.results_display google -y
```

Make it the site default search (core setting):

```bash
drush cset search.settings default_page google_search -y
```

When Google Programmable Search is the **default** search page, the module's
`google_cse_form_search_block_form_alter()` rewrites the core search block: it renames the
input to `query_key`, attaches the watermark libraries, and — if `results_display` is
`google` — repoints the form action at `https://cse.google.com/cse` with the `cx` as a
hidden field so submitting jumps straight to Google's hosted results.

## permission

`search Google CSE` ("View Google Programmable Search") gates running searches. Managing
the search page config is gated by core's `administer search`.
