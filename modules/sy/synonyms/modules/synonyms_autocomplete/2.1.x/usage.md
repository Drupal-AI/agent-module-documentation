Synonyms Autocomplete Widget adds a synonyms-friendly autocomplete widget (and reusable form element) for entity-reference fields, so typing a synonym — not just an entity's primary label — surfaces the matching entity as a suggestion.

---

The submodule registers a field widget `synonyms_autocomplete` for `entity_reference` fields and a
reusable `synonyms_entity_autocomplete` render/form element (extends core `Textfield`). It also adds an
autocomplete behavior service (`synonyms.behavior.autocomplete`, tagged `synonyms_behavior`, also a
`WidgetInterface`) and a dedicated autocomplete route. As the user types, suggestions come first from
core's default entity-reference selection handler (matching labels), and — if fewer than the requested
count — are topped up with synonym matches via `ProviderService::getSynonymConfigEntities()` +
`synonymsFind()` (LIKE, `escapeLike`-quoted). The widget stores three settings (`suggestion_size`,
`suggest_only_unique`, `match` = CONTAINS/STARTS_WITH); a global settings form
(`synonyms_autocomplete.settings`) holds `default_wording`. The autocomplete endpoint
`/synonyms_autocomplete/entity/autocomplete/{target_type}/{token}` requires permission
**`access synonyms entity autocomplete`**; the `{token}` is an HMAC (hash-salt signed) key into a
key-value store that pins the lookup's target type/bundles/size/match so request parameters can't be
tampered with. Only entities with an autocomplete behavior enabled for their type/bundle contribute
synonym suggestions; all lookups run entity queries with `accessCheck(TRUE)`.

---

- Let editors pick a taxonomy term by typing one of its synonyms in an autocomplete.
- Reference a node by an alternate title/alias instead of its exact label.
- Match on "contains" or "starts with" against both labels and synonyms.
- Cap the number of suggestions with `suggestion_size`.
- Show at most one suggestion per entity when several synonyms match (`suggest_only_unique`).
- Format each suggestion with custom wording (`default_wording`).
- Add synonym-aware autocomplete to any entity-reference field via Manage form display.
- Reuse the `synonyms_entity_autocomplete` element in a custom form.
- Restrict suggestions to specific target bundles (from the field's handler settings).
- Improve data-entry speed when users know entities by informal names.
- Enable the "autocomplete" behavior per entity type/bundle to opt bundles in.
- Grant `access synonyms entity autocomplete` to roles that use the widget.
- Provide multi-value tagging where each token can be an entity or a synonym of one.
- Keep autocomplete lookups access-checked and tamper-resistant (HMAC token).
- Support user reference by username or a synonym.
- Reduce mis-references by surfacing the canonical entity behind an alias.
