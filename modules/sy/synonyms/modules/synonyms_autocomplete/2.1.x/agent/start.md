# Synonyms Autocomplete Widget (synonyms_autocomplete) — agent index

Synonyms-friendly autocomplete for `entity_reference` fields: typing a synonym surfaces the entity.
Depends on `synonyms`. `configure` → `synonyms_autocomplete.settings`. Provides a permission and a
config schema.

- **Widget + form element, settings, the autocomplete route/permission, custom-form use** →
  [configure/widget.md](configure/widget.md)

Key facts:
- Field widget id `synonyms_autocomplete` (`entity_reference`, `multiple_values`); form element
  `synonyms_entity_autocomplete` (extends `Textfield`).
- Behavior service `synonyms.behavior.autocomplete` (`synonyms_behavior` tag, `WidgetInterface`);
  method `autocompleteLookup($keyword, $token)`.
- Route `synonyms.entity_autocomplete` = `/synonyms_autocomplete/entity/autocomplete/{target_type}/{token}`,
  permission **`access synonyms entity autocomplete`**; `{token}` = `Crypt::hmacBase64(serialize($settings),
  hash_salt)` key into key-value store `synonyms_entity_autocomplete`.
- Widget settings: `suggestion_size` (int, default 10), `suggest_only_unique` (bool), `match`
  (`CONTAINS`|`STARTS_WITH`). Global config `synonyms_autocomplete.settings.default_wording`.
