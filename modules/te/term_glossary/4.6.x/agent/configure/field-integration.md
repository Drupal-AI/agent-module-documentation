# Configure: enable auto-highlighting on a field

Highlighting is opt-in per field-formatter. The module adds an **"Enable term glossary"**
checkbox (and an optional vocabulary override) to the formatter settings of eligible fields via
`hook_field_formatter_third_party_settings_form()`. Only these formatter plugin ids are eligible
(`TermGlossaryHooks::checkFormatter()`): `text_default`, `text_trimmed`, `string`.

## Enable in the UI

*Manage display* of the entity (`/admin/structure/types/manage/<type>/display`, or any entity's
display) → open the gear on a text/string field → check **Enable term glossary** → optionally
pick one or more vocabularies in **Select the vocabularies…** (an entity-autocomplete of
`taxonomy_vocabulary`). If left empty, the global `vocab` setting applies.

## What gets stored

Third-party settings on the field's view-display component, namespace `term_glossary`
(schema `field.formatter.third_party.term_glossary`):

| Setting | Type | Meaning |
|---|---|---|
| `glossary` | bool | Highlighting on for this field. |
| `glossary_vocabulary` | sequence of `{ target_id: <vocab machine name> }` | Per-field vocabulary override; empty → global `vocab`. |

Set it in code on an `EntityViewDisplay`:

```php
$display->getComponent('body');
$display->setComponent('body', [
  'type' => 'text_default',
  'third_party_settings' => [
    'term_glossary' => [
      'glossary' => TRUE,
      'glossary_vocabulary' => [['target_id' => 'glossary']],
    ],
  ],
])->save();
```

## Runtime flow

`TermGlossaryHooks::preprocessField()` runs on every field render. For an eligible formatter with
`glossary` on, it resolves the vocabularies
(`TermGlossaryManager::getVocabulariesFromFieldPreprocessVariables()`), finds the root entity
(`getRootEntityFromFieldPreprocessVariables()` — walks `paragraph` parents up to the host), then
calls `TermGlossaryManager::replaceFieldValue($markup, $vocabularies, $root_entity)` on each item.
The returned HTML replaces the item content (wrapped in `Markup::create` so it is not
re-filtered), term-list cache tags bubble up, and the handler's libraries/settings attach when
at least one replacement occurred.

## Scanner scope controls

- Descendant text of `<a>` and `<img>` is never scanned.
- Any element carrying the CSS class `glossary-exclude` (and its descendants) is skipped.
- `ignore_tags` (global) adds more tag names to skip.
- Input that is not valid UTF-8 is skipped (logged at debug level).

## Per-term matching overrides (`per_term_options`)

When `per_term_options` is enabled globally, add these optional fields to the taxonomy vocabulary
to override the global match rules per term:

| Field (machine name) | Type | Effect |
|---|---|---|
| `field_full_word` | numeric | `1` = force full-word for this term, `0` = disable it, other/empty = use global. |
| `field_case_sensitive` | numeric | `1` = force case-sensitive, `0` = disable, other/empty = use global. |
| `field_boundary_exceptions` | text | Non-empty value overrides the global `boundary_exceptions` for this term. |

## Per-node control

The `term_glossary_per_node` submodule adds node-type settings (enable per node type, allow a
per-node checkbox, default state, and an optional per-node vocabulary override). Enable that
submodule if editors need to toggle the glossary on individual nodes.
