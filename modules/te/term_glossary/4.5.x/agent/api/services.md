# API: manager service, alter hooks, implemented hooks

## Service `term_glossary.manager`

`Drupal\term_glossary\Service\TermGlossaryManager` — the highlight engine. Also aliased to its
interface `Drupal\term_glossary\Service\TermGlossaryManagerInterface`. Constructor args (see
`term_glossary.services.yml`): `config.manager`, `entity_type.manager`, `cache.default`,
`language_manager`, `renderer`, `module_handler`, `logger.channel.term_glossary`, the handler
plugin manager, `entity.repository`, `cache_contexts_manager`.

Public methods:

| Method | Purpose |
|---|---|
| `replaceFieldValue($input, $vocabularies, $root_entity = NULL)` | Core entry point. Loads/caches the vocabulary term list, DOM-scans `$input`, replaces matches via the active handler. Returns `FALSE` when input is empty / not UTF-8 / no handler, else `['cache_tags'=>..., 'html'=>..., 'count'=>N]` (`html`/`count` only when matches were found). |
| `attachLibrariesAndSettings(&$variables)` | Delegates to the active handler to add libraries + settings. |
| `getConfig(): ?ImmutableConfig` | The `term_glossary.glossaryconfig` immutable config. |
| `getHandler()` | The instantiated handler, or `NULL` if `integration_type` is unset/invalid. |
| `getVocabulariesFromFieldPreprocessVariables(&$variables)` | Resolves per-field vocab override (or global `vocab`) from `preprocess_field` variables; `FALSE` if glossary not enabled on that field. |
| `getFieldFormatterThirdPartySettingsElements($plugin, $field_definition)` | Builds the "Enable term glossary" + vocabulary form elements for the formatter settings. |
| `getRootEntityFromFieldPreprocessVariables($variables)` | Returns the root host entity (walks `paragraph` parents). |

### Matching internals worth knowing

- Term list is per `vocabulary`+`langcode`+`user.roles` cache context, cached PERMANENT with tags `<config cache tags> + taxonomy_term_list:<vid>`. Only published terms in the current language are loaded (`status=1`), sorted by `weight`.
- Patterns are built with `preg_quote($name, '/')`; whole-word mode uses `\b` or a Unicode lookbehind/lookahead character class derived from the admin-set `boundary_exceptions`; `u` flag always, `i` unless case-sensitive.
- Matches are first replaced by numeric placeholders (`{{n}}`), then each placeholder is swapped for the handler-built, isolation-rendered markup — so a term name that also occurs in another term's description is not double-processed.

## Alter hooks the module invokes

Documented in `term_glossary.api.php`:

| Hook | Fired from | Signature |
|---|---|---|
| `hook_term_glossary_alter_results(&$results, $terms, $search_term)` | `TermGlossaryController::apiSearchPerLetter()` / `apiSearchPerTerm()` (`invokeAll`) | Alter the JSON array of matched-term results. |
| `hook_term_glossary_alter_result(&$result, $term, $term_id)` | `TermGlossaryController::apiGetTermById()` (`invokeAll`) | Alter the single-term JSON result. |
| `hook_term_glossary_term_data_alter(&$term_data, $term, $langcode)` | `TermGlossaryManager::updateTermList()` (`alter`) | Alter each term's cached data array (tid/name/lang/synonyms/match flags). |
| `hook_term_glossary_term_match_alter(&$match_tag, &$term_data, &$match_value)` | `TermGlossaryManager::buildMatchTag()` (`alter`) | Alter the render array produced for a single match before it is rendered. |

## Hooks the module implements (`Drupal\term_glossary\Hook\TermGlossaryHooks`)

OOP hooks (with `#[LegacyHook]` shims in `term_glossary.module`):

- `help` — help page text.
- `theme` — declares `glossary_alphabetical_block`.
- `field_formatter_third_party_settings_form` / `field_formatter_settings_summary_alter` — add + summarize the "Enable term glossary" toggle on `text_default`/`text_trimmed`/`string` formatters.
- `preprocess_field` — the runtime highlighter (see [configure/field-integration.md](../configure/field-integration.md)).
