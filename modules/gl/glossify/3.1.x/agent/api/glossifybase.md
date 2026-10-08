# `GlossifyBase` — the matching engine

`Drupal\glossify\GlossifyBase` (abstract, extends core `FilterBase`,
`ContainerFactoryPluginInterface`). Submodule filters extend it; it provides the shared logic. It is
**not** a plugin *manager* — the plugin type is core's Filter.

## What a subclass must do

Implement `settingsForm()`, `process($text, $langcode)`, and `setConfiguration()`. In `process()`:
build a `$terms` array (objects with `->id`, `->name`, `->name_norm`, `->tip`, and optionally
`->synonyms`), then call `parseTooltipMatch()`. See the submodules for concrete examples.

Injected services (constructor): `logger.factory`, `renderer`, `path.current`, `database`,
`entity_field.manager`, `entity_type.bundle.info`.

## `parseTooltipMatch($text, $terms, $case_sensitivity, $first_only, $displaytype, $tooltip_truncate, $urlpattern, $ignore_tags, $langcode)`

The core routine. Behavior:

- Loads `$text` into a DOM (`Html::load`) and works on text nodes via XPath.
- Builds one regex per term: `/(?<=^|\s)(<quoted name>)(?=\s|$|[^\w\s])/u` plus `i` when
  case-insensitive. Also adds a pattern per **synonym**. Patterns are `ksort()`ed.
- **Skips** text inside `<a>` and `<abbr>`, inside any configured `ignore_tags`, and inside any
  element with class **`glossify-exclude`** (matched via `contains(concat(" ",…," ")," glossify-exclude ")`).
- With `first_only`, terms already inside existing `<a>`/`<abbr>` count as the first occurrence.
- Removes **overlapping/nested** matches (a shorter term inside a longer match is dropped).
- If the current page path equals the term's own URL, the match is left as plain text (no self-link).
- Replaces each match according to `$displaytype`:
  - `tooltips` → `#theme => 'glossify_tooltip'` → `<abbr class="glossify-tooltip-tip">`.
  - `links` → `#theme => 'glossify_link'` → `<a class="glossify-tooltip-link">` (URL =
    `str_replace('[id]', $term->id, $urlpattern)`).
  - `tooltips_links` → link **with** a `title` tooltip.
- Tooltips are sanitized: HTML stripped, truncated to **300 chars** when `tooltip_truncate` is on.

## Shared settings every subclass exposes

(names are prefixed differently per submodule — see each submodule doc)

| Concept | Meaning |
|---|---|
| case sensitivity | case-sensitive matching (bool) |
| first only | link only first occurrence per field (bool) |
| ignore tags | comma-separated HTML tags to skip |
| type | `tooltips` \| `links` \| `tooltips_links` |
| tooltip truncate | truncate tip to 300 chars (bool) |
| bundles/vocabs | which source bundles supply terms (semicolon-joined string) |
| urlpattern | link URL with `[id]` token |
| synonyms field | plain-text field providing extra match strings |

## Synonyms (`loadSynonyms()` / `getSynonymsFieldOptions()`)

`getSynonymsFieldOptions($entityType)` lists `string` (Text plain) fields (excluding title/name)
across the entity type's bundles for the "Synonyms field" select. `loadSynonyms()` queries
`<entity>__<field>` for published, language-matched values on the selected bundles and attaches them
as `->synonyms` on each term, so alternate spellings also match. The field must exist on every
targeted bundle or synonyms are skipped for that bundle.

Config storage: subclass settings are stored on the filter inside the text format config entity
(`filter.format.<format>` → `filters.<filter_id>.settings`). Multi-value selections (bundles/vocabs)
are stored as a `;`-joined **string** (schema does not accept arrays) — see `setConfiguration()`.
