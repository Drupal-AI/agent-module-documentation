# Paragraphs Sets — agent index

Insert a whole **pre-configured group of paragraphs** into a Paragraphs field in one click. Sets
are `paragraphs_set` config entities, offered on the stable **Paragraphs** widget. Depends on
`paragraphs`.

- **Define sets (the config entity), enable them on a field widget, default set** →
  [configure/sets.md](configure/sets.md)
- **Supply default/complex field data via alter hooks** → [hooks/data-alter.md](hooks/data-alter.md)

Key facts:
- Config UI / configure route: `entity.paragraphs_set.collection` (`/admin/structure/paragraphs_set`);
  add form route `paragraphs_sets.set_add`. Permission: `administer paragraphs sets`.
- Config entity `paragraphs_set` (config prefix `paragraphs_sets.set.*`; exported keys `id`,
  `label`, `description`, `icon_uuid`, `paragraphs`). `paragraphs` = list of
  `{bundle: <paragraph_type>, data: {field: value}}`.
- Widget third-party settings (on the `paragraphs` widget, under
  `third_party_settings.paragraphs_sets` of an `entity_form_display` component):
  `use_paragraphs_sets` (enable), `sets_allowed` (limit), `default_set` (seed default value).
- Alter hooks: `hook_paragraphs_set_data_alter()`, `hook_paragraphs_set_SET_data_alter()`,
  `hook_paragraphs_set_SET_FIELD_NAME_data_alter()`, `hook_paragraphs_sets_set_static_icon_uri_alter()`.
- Runtime helpers: static `Drupal\paragraphs_sets\ParagraphsSets` (`getSets()`, `getSetsOptions()`).
