# Synonyms Select Widget (synonyms_select) — agent index

Synonyms-friendly select/dropdown for `entity_reference` fields: each entity is listed once per synonym.
Depends on `synonyms`. `configure` → `synonyms_select.settings`. No permissions.

- **Enable the widget, its settings, custom-form use of the element** → [configure/widget.md](configure/widget.md)

Key facts:
- Field widget id `synonyms_select` (`entity_reference`); render element `synonyms_entity_select`
  (extends `Select`), option key format `"<entity_id>:<synonym>"` (const `DELIMITER = ':'`).
- Behavior service `synonyms.behavior.select` (`synonyms_behavior` tag, `WidgetInterface`), id `select`;
  `selectGetSynonymsMultiple()` builds per-entity synonym options.
- Widget/global settings (`synonyms_select.settings`): `default_wording`
  (`@synonym is the @field_label of @entity_label`), `sort_select` (bool, default FALSE).
- Opt bundles in via *Structure → Synonyms configuration → Manage behaviors* (enable **Select**).
