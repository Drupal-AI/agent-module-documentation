# Configure: global glossary settings

Form: `Drupal\term_glossary\Form\TermGlossaryConfigForm` (form id `glossary_config_form`).
Route `term_glossary.glossary_config_form` → `/admin/config/glossary`, requires
`administer site configuration`. Menu link under *Configuration › Content* (`term_glossary.glossary_config_form`).

Editable config object: **`term_glossary.glossaryconfig`**. The dialog handler stores its own
options in **`term_glossary.glossaryconfig.jqueryui`** (written by the handler's submit, not the
main form's `submitForm`).

## `term_glossary.glossaryconfig` keys

| Key | Type | Meaning |
|---|---|---|
| `vocab` | string | **Required.** Comma-joined taxonomy vocabulary machine names used as glossary source. The form stores a multiselect as `implode(',', $vocabs)`. |
| `integration_type` | string | Handler plugin id: `default` (jQuery UI dialog), `custom_js`, `link`, plus `abbr`/`tippy` from submodules. Empty → no handler, highlighting is skipped and a warning is logged. |
| `single_match_per_content` | bool | Match each term only once across the whole entity (keyed by root entity id; paragraphs resolve to their root). |
| `single_match` | bool | Match each term only once per field. Ignored when `single_match_per_content` is on. |
| `full_word` | bool | Only match whole-word occurrences (uses `\b` or a lookbehind/lookahead built from `boundary_exceptions`). |
| `boundary_exceptions` | string | Characters (no spaces/commas) that should NOT count as word boundaries, e.g. `-`. Only used when `full_word`. |
| `case_sensitive` | bool | Case-sensitive matching (regex `i` flag omitted). |
| `per_term_options` | bool | Allow individual terms to override `full_word`/`case_sensitive`/`boundary_exceptions` via fields — see [field-integration.md](../configure/field-integration.md). |
| `term_synonyms` | bool | Also match synonyms taken from `synonyms_field`. |
| `synonyms_field` | string | Machine name of a multi-valued `string` field on `taxonomy_term` holding synonyms. Only such fields are offered. |
| `match_all_synonyms` | bool | When single-match is on, still allow each distinct synonym to match once. |
| `exclude_self_reference` | bool | When rendering a term's own content, do not link that same term (removes it from the term list). |
| `view_mode` | string | Taxonomy term view mode used to render the popup body. Empty → name + `Xss::filter(description)`. |
| `json_term_cache` | integer | Browser cache max-age (seconds) for the get-term-by-id JSON response. Empty → 3600; `0` → no cache headers. |
| `ignore_tags` | string | Comma-separated HTML tag names whose descendant text is skipped by the scanner. `a` and `img` descendants, and any element with class `glossary-exclude`, are always skipped. |

### `term_glossary.glossaryconfig.jqueryui` keys (default handler)

`dialog_width`, `dialog_height`, `dialog_min_height` (strings like `500px` or `66%`),
`dialog_title` (label; falls back to "Term definition"), `dialog_close_button` (bool).
Exposed to JS as `drupalSettings.termGlossary`.

## Set via drush / PHP

```php
$config = \Drupal::configFactory()->getEditable('term_glossary.glossaryconfig');
$config
  ->set('vocab', 'glossary,acronyms')     // comma-joined vocabulary machine names
  ->set('integration_type', 'default')    // handler plugin id
  ->set('full_word', TRUE)
  ->set('single_match_per_content', TRUE)
  ->set('view_mode', '')                  // empty = name + description
  ->set('json_term_cache', 3600)
  ->save();
```

```bash
ddev drush cset term_glossary.glossaryconfig vocab 'glossary,acronyms' -y
ddev drush cset term_glossary.glossaryconfig integration_type default -y
```

Config schema lives in `config/schema/term_glossary.schema.yml`
(`term_glossary.glossaryconfig`, `term_glossary.glossaryconfig.jqueryui`). There is no
`config/install`, so all keys are unset until the form (or `cset`) writes them; unset booleans
are read with `?? FALSE`. Term lists are cached with tag `taxonomy_term_list:<vid>` and are
rebuilt automatically when a term in the vocabulary changes.
