# Entity Browser - Table Layout — agent index

Adds one Entity Reference field widget, **`entity_reference_browser_table_widget`** ("Entity
Browser - Table"), that displays the current selection as a sortable table instead of Entity
Browser's grid. Subclasses `entity_browser`'s `EntityReferenceBrowserWidget`; requires the
Entity Browser module. No settings form of its own, no routes, no permissions, no Drush,
`configure: null`. Ships one config-schema and one alter hook.

- **Choose the widget on a field / its settings (incl. the Status column) / config shape** →
  [configure/widget.md](configure/widget.md)
- **Add extra columns/cells to the table (`hook_entity_browser_table_alter`) or subclass it** →
  [hooks/alter.md](hooks/alter.md)

Key facts:
- Widget id `entity_reference_browser_table_widget`; applies to `entity_reference` and
  `entity_reference_revisions` fields; set as the widget `type` in an `entity_form_display`.
- All parent Entity Browser settings apply (entity_browser, field_widget_display,
  field_widget_edit/remove/replace, selection_mode, open). The **only** added setting is
  `additional_fields.options.status` (a checkbox) that adds a Status column.
- The Status column shows moderation state when `content_moderation` marks the entity moderated,
  otherwise Published/Unpublished from the `status` field.
