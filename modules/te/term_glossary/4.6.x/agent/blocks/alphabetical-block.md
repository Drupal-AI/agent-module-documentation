# Block: Glossary alphabetical

Block plugin `glossary_alphabetical_bock`
(`Drupal\term_glossary\Plugin\Block\GlossaryAlphabeticalBock`, admin label "Glossary
alphabetical block"). Renders an A–Z glossary/search widget that fetches results over AJAX from
the module's JSON endpoints. Place it like any block; it works independently of the per-field
auto-highlighting.

## Block settings

| Setting | Values | Effect |
|---|---|---|
| `search_type` | `search_only`, `all` (default), `only_letters` | Show just the search box, box + A–Z letters, or letters only. |

Schema: `block.settings.glossary_alphabetical_bock` (key `search_type`). Default configuration is
`['search_type' => 'all']`.

`build()` sets `#theme => glossary_alphabetical_block`, passes `#type => <search_type>`, and
attaches library `term_glossary/glossary.alpha` (`assets/js/block-alpha.js` + `assets/css/style.css`).
Theme hook `glossary_alphabetical_block` is declared in `TermGlossaryHooks::theme()`; template
`templates/glossary-alphabetical-block.html.twig` renders the search input, the A–Z links, and an
empty `#glossary-alpha-results` container that JS fills in.

## JSON endpoints the block calls

Controller `Drupal\term_glossary\Controller\TermGlossaryController`. All three require
`_permission: 'access content'`. Every endpoint serves only **published** terms from the
**configured glossary vocabularies** that the **current user may view**: the two search queries
add `condition('vid', <configured>, 'IN')` + `condition('status', 1)` + current langcode, and all
three then pass loaded terms through `filterViewableTerms()` / `getViewableTranslation()`, which
keep only terms whose context translation returns `access('view')` true.

| Route name | Path | Method | Behavior |
|---|---|---|---|
| `term_glossary.glossary_controller_apiSearch_per_letter` | `/glossary-search-letter/{letter}` | `apiSearchPerLetter($letter)` | `{letter}` must match `/^[a-zA-Z]$/` (upper-cased before the test). Returns terms whose name `STARTS_WITH` the letter, restricted to configured vocabularies, published, current language, and viewable. |
| `term_glossary.glossary_controller_apiSearch_per_term` | `/glossary-search-term?t=<text>` | `apiSearchPerTerm()` | Query param `t` is trimmed and `Html::escape`d; matches by `CONTAINS`, then falls back to a `LIKE` (via `escapeLike`) if none. Same vocabulary / published / language / viewable filters. |
| `term_glossary.glossary_controller_get_term_by_id/{tid}` | `/glossary-get-term-by-id/{tid}` | `apiGetTermById($tid)` | `loadGlossaryTerm($tid)` loads one term by id and returns it only if `{tid}` is numeric, the term's bundle is one of the configured vocabularies, it is published, and it is viewable; otherwise a "No results" message. Adds browser/shared cache headers per `json_term_cache` for anonymous requests only. |

Each result item is built by `buildTermResult()`:

```json
{ "tid": "12", "lang": "en", "name": "Term name",
  "description": "<raw description>", "html": "<rendered popup body>" }
```

The `html` field is the popup body: when `view_mode` is empty it is
`"<p><strong>" . Html::escape(name) . "</strong></p>" . Xss::filter(description)`; otherwise it is
the term rendered through the configured view mode. The search endpoints invoke
`hook_term_glossary_alter_results()`; the by-id endpoint invokes `hook_term_glossary_alter_result()`.

Front-end JS: `block-alpha.js` wires the letter links and search button to the two search
endpoints and appends each `item.html` into `#glossary-alpha-results`. The dialog handler's
`glossary-content-dialog.js` calls the by-id endpoint when a highlighted `.glos-term` is clicked
and injects `data.html` into the jQuery UI dialog.
