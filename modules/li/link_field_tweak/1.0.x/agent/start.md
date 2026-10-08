# Link Field tweaks — agent index

Hook-based tweaks for core's `link` field / `link_default` widget (no new field type). Config
UI at `/admin/config/content/link-field-tweak` (route `link_field_tweak.settings`, requires
`administer site configuration`).

- **Site-wide settings, per-widget third-party settings, how/where stored, drush** →
  [configure/settings.md](configure/settings.md)
- **The two field formatters (`link_text`, `link_text_empty`)** →
  [configure/formatters.md](configure/formatters.md)

Three storage locations:
- Site-wide: config object `link_field_tweak.settings` (`widget_field_order`, `add_another_link`,
  `uri_part_required`).
- Per widget: `entity_form_display` component `third_party_settings.link_field_tweak.*`.
- Per formatter: `entity_view_display` component `settings.link_text` (formatter `link_text` /
  `link_text_empty`).

Also ships an EntityReferenceSelection plugin `nodeextend` + an autocomplete controller/route
(`link_field_tweak.entity_autocomplete`) used only when a widget's `autocomplete_route_name_change`
is on; it extends core's validated autocomplete matcher (no separate access concern).
