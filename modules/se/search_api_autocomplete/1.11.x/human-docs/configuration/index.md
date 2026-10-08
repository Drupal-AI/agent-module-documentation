# Configuration

Autocomplete is configured **per search**, from the Autocomplete tab of each
Search API index. There's no global on/off switch and no single settings form —
you enable it on the specific searches where you want it, one at a time, and tune
each independently. Because each enabled search is stored as exportable
configuration, you can build it here and deploy it to production with your normal
config workflow.

## Open the Autocomplete tab

1. Log in as a user with the **Administer Search API Autocomplete**
   (`administer search_api_autocomplete`) permission — an administrator by default.
2. Go to **Configuration → Search and metadata → Search API**, open the index you
   want, and click the **Autocomplete** tab
   (`/admin/config/search/search-api/index/{index}/autocomplete`).

The tab lists every autocomplete-capable search on that index — Views search
filters and Search API Pages are discovered automatically. Each one has a checkbox
to enable autocomplete and, once enabled, an **Edit** link to configure it.

## Enable a search and choose its suggesters

Tick the box next to a search to enable autocomplete on it, then edit it. The main
choice is **which suggesters run** — the plugins that actually produce
suggestions. You can enable more than one on the same search; they are combined in
the dropdown. The bundled suggesters are:

- **Server** — completions supplied by the search backend itself (for example
  Solr's term suggestions). This only works if your search server supports
  autocomplete; on a plain database backend it has nothing to offer.
- **Live results** — runs the search behind the scenes and renders the matching
  result items (title and link) directly in the dropdown, so users can click
  straight through to a result. Works with **any** backend.
- **Custom script** — calls an external script or URL to generate suggestions, for
  bespoke logic. This suggester is only available if it has been allowed globally
  (see *Allowing custom scripts* below).

When several suggesters are active you can order them (a weight per suggester) and
cap how many suggestions each contributes.

## Tune how the dropdown behaves

Each enabled search has a few options controlling the feel of the autocomplete:

- **Maximum number of suggestions** — how many entries the dropdown shows at once.
  Keep it modest so the list stays readable.
- **Minimum length** — how many characters the user must type before suggestions
  start appearing. A value of 1 fires almost immediately; a higher value avoids
  noisy suggestions on a single letter.
- **Show result count** — whether to display the predicted number of results for a
  suggestion.
- **Delay** — a debounce, in milliseconds, so the module waits until the user
  pauses typing before requesting suggestions. Raising it reduces requests to the
  server on fast typing; 0 fires on every keystroke.

## Allowing custom scripts

The **Custom script** suggester is disabled globally by default because it can run
external logic. To make it selectable, an administrator must turn on the global
*enable custom scripts* setting
(`search_api_autocomplete.settings:enable_custom_scripts`). Leave it off unless you
specifically need a custom-script suggester and trust who can configure it.

## Who can use each search's suggestions

Beyond the single administer permission, the module generates **one permission per
autocomplete-enabled search**, found on **People → Permissions**. That permission
controls whether a given role's requests to *that* search's autocomplete endpoint
are allowed — so you can, for example, expose autocomplete on a public site search
to everyone while restricting it on an internal search. Grant these to the roles
that should see suggestions.

## Save and deploy

Save the search's autocomplete settings when you're done. Each enabled search is
stored as a configuration entity (`search_api_autocomplete.search.{id}`), so you
can export it and move it between environments with your usual config workflow —
for example `drush config:export` on the source site and `drush config:import` on
the target.
