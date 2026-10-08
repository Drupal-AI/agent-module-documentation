<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, controller & tooltip fetch flow

All routes live in `ckeditor_taxonomy_glossary.routing.yml`; all handlers are on
`Controller/GlossaryAutocompleteController` (extends `ControllerBase`, injects
`entity_type.manager`, `language_manager`, `form_builder`, `renderer`, `current_user`).

## Read routes (permission `access content`)

| Route | Path | Method | Returns |
|-------|------|--------|---------|
| `…autocomplete` | `/glossary/autocomplete/{text}` | GET | JSON array of matching glossary terms |
| `…autocomplete_lang` | `/glossary/autocomplete/{text}/{langcode}` | GET | as above, filtered to `langcode` |
| `…term_description` | `/glossary/description/{tid}` | GET | `{id,name,description,langcode,language_name}` |
| `…term_description_lang` | `/glossary/description/{tid}/{langcode}` | GET | as above for a specific translation |
| `…term_info` | `/glossary/term/{tid}` | GET | `{id,name,langcode,language_name}` |

- `{tid}` is constrained `\d+`; `{langcode}` is constrained `[a-z]{2}(-[a-z]{2})?`.
- **Autocomplete** (`autocomplete()`): trims `$text`, searches only when
  `2 <= strlen <= 100`. Entity query: `->accessCheck(TRUE)->condition('vid','glossary')
  ->condition('name',$text,'CONTAINS')->range(0,20)->sort('name')`. Each match returns
  `id,label,description,langcode,language_name`; `description` is `strip_tags`'d and truncated
  to 100 chars. Errors are logged, never surfaced. `autocompleteByLanguage()` is the same but
  adds `->condition('langcode',$langcode)`, `range(0,10)`, and only a lower length bound (>=2).
- **termDescription() / termDescriptionByLanguage() / termInfo()**: `load($tid)`, then require
  `bundle() === 'glossary'` else `NotFoundHttpException`. `termDescription`/`termInfo` fall
  back to the current-language translation if present; `termDescriptionByLanguage` requires the
  requested translation to exist (else 404). `description` here is the **processed** value
  (`->processed`, format-filtered HTML), not stripped.
- Responses are `CacheableJsonResponse` with cache tag `taxonomy_term_list:glossary` (and the
  term as a cacheable dependency for the tid routes). The configured `cache_duration` sets
  max-age / shared-max-age; `"0"` emits no-cache headers.

## Write routes (permission `create glossary terms via editor`, restricted)

- **`…create_term` — `POST /glossary/create-term`**: also carries
  `_csrf_request_header_token: 'TRUE'`. `createTerm(Request)` re-checks the permission in code
  (403 JSON otherwise), decodes JSON body (400 on invalid JSON / missing `name`), trims
  `name`/`description`/`langcode`, enforces `mb_strlen` limits (name ≤255, description ≤500),
  and validates `langcode` against `languageManager()->getLanguages(STATE_ALL)`. It rejects
  duplicates (`loadByProperties` on vid+name+langcode → 409 with the existing term). New term
  is created in vocabulary `glossary`; the description is stored with
  `format => filter_fallback_format()` (plain_text) — deliberately not the author's default
  format. On success invalidates `taxonomy_term_list:glossary` and returns the created term.
- **`…term_form` — `/glossary/term-form/{tid}`**: `getTermForm()` re-checks the permission and
  returns a static HTML snippet (`form_html`, `title`) for the create-term modal. `{tid}` is
  accepted but editing is not implemented.

## Settings route

- **`…settings` — `/admin/config/content/ckeditor-taxonomy-glossary`**: `GlossarySettingsForm`,
  permission `administer glossary terms`, `_admin_route: true`. See
  [../config/settings.md](../config/settings.md).

## Front-end fetch flow

`js/glossary-tooltip.js` (`Drupal.behaviors.glossaryTooltip`) binds every
`.glossary-link[data-glossary-id]`. On show it uses the preloaded
`drupalSettings.ckeditorTaxonomyGlossary.terms[tid]` if present, otherwise
`fetch('/glossary/description/'+tid)` (honouring the `cacheDuration` setting for cache
headers). The term `name` is rendered via `textContent`; the `description` HTML is inserted via
innerHTML after client-side stripping of `<script>` elements and `on*` attributes. Autocomplete
in the editor calls `/glossary/autocomplete/{text}` (from `autocompleteUrl`).
