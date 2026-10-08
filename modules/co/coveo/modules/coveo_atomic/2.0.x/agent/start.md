<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Coveo Atomic Search (coveo_atomic) — agent index

Submodule of **Coveo**. Embeds Coveo's **Atomic** web-component search UI as a Drupal block. Depends on
`coveo` (`coveo_atomic.info.yml`). Package Search. Core `^10 || ^11`. No permissions, no config schema.

- **The block, theme hook, token attach and Twig filters** → [blocks/atomic-search.md](blocks/atomic-search.md)

## What it provides

- **Block** `coveo_atomic` (`src/Plugin/Block/CoveoAtomicSearch.php`) with deriver
  `src/Plugin/Derivative/CoveoAtomicBlocks.php` — one derivative per `coveo_search_component`
  (admin label "Coveo Atomic: <label>", config dependency on the component). Block config: `widget_id`.
- **Theme** `coveo_atomic_search` (template `templates/coveo-atomic-search.html.twig`) — variables
  `id`, `search`, `fields` (default `coveo_uri`/`coveo_date`/`coveo_excerpt`), `facets`, `tabs`.
  Suggestions `coveo_atomic_search__<id>`, `__<search>`, `__<id>__<search>`.
- **Preprocess** `template_preprocess_coveo_atomic_search()` (in `coveo_atomic.module`) — attaches the
  `coveo_atomic/atomic` library and `drupalSettings.coveo_atomic[<id>]` = `{search, accessToken,
  organizationId, analyticsMode: 'legacy'}`. `accessToken` = `$searchComponent->getToken(request,
  currentUser)` (per-user, via the component's security provider).
- **Twig extension** `src/Twig/AtomicExtension.php` — filters `atomic_field` and `atomic_fields`
  (variadic; take the search id) mapping Drupal field names to Coveo names via the org `FieldConverter`.
- **Library** `coveo_atomic/atomic` (`coveo_atomic.libraries.yml`) → `js/coveo_atomic.js`, `css/coveo.css`,
  and external `coveo_atomic/external` loading Coveo Atomic v3 ESM + CSS from `static.cloud.coveo.com`.
- **JS** `js/coveo_atomic.js` — `Drupal.behaviors.coveoAtomic` initializes each `atomic-search-interface`
  with the token/org and a `renewAccessToken` callback that GETs `/coveo/refresh?search=<id>`.

## Hooks

`src/Hook/CoveoAtomicHooks.php` — `hook_help`, `hook_theme`, `hook_theme_suggestions`. Search results
are rendered client-side by Coveo's Atomic web components, not server-side.
