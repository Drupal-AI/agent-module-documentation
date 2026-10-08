# Unique Field Ajax — agent index

Marks a single-value field (or a content type's node title) as **unique per bundle**, with
optional per-language, case-sensitive, AJAX-live, and warn-only modes. No admin settings page
(configure=null), no permission of its own. State = third-party settings under the
`unique_field_ajax` namespace on the `field.field.*` (or `node.type.*`) config entity.

- **Enable uniqueness on a field / on a node title; the settings keys and where they are stored** →
  [configure/uniqueness.md](configure/uniqueness.md)
- **Alter the uniqueness query or its results (the two invited hooks) and the public check function** →
  [hooks/alter-hooks.md](hooks/alter-hooks.md)

Key facts:
- Settings keys: `unique`, `per_lang`, `case_sensitive`, `use_ajax`, `no_enforce`, `message`, `message_warning`.
- Eligible field types (single-cardinality only): `string`, `string_long`, `list_string`, `text`, `email`,
  `entity_reference`, `path`, `uri`, `link`, `integer`, `decimal`, `color_field_type`.
- Stored at `field.field.<entity>.<bundle>.<field>` → `third_party_settings.unique_field_ajax.*`
  (titles: `node.type.<bundle>` → `third_party_settings.unique_field_ajax.*`).
- Enforcement: `#element_validate` = `unique_field_ajax_validate_unique`; AJAX event `finishedinput`,
  library `unique_field_ajax/unique_event`. Check function: `unique_field_ajax_is_unique()`.
