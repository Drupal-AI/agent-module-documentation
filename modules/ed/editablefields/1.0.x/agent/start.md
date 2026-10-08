# Editable Fields — agent index

Adds one field formatter, **`editablefields_formatter`** ("Editable field"), available on
**all** field types, that renders a field's edit widget (inline or in a modal popup) on the
entity display so the value can be edited/saved without the full edit form. No configure
route (`configure: null`) and no global settings page — all configuration is per-field in
the display component's formatter settings.

- **Enable inline/popup editing on a field + all formatter settings (form mode, behaviour,
  access, autosave) and where they are stored** → [configure/formatter.md](configure/formatter.md)
- **Permissions that gate inline editing** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- The formatter is made available for every field type via
  `hook_field_formatter_info_alter()` (it has empty `field_types = {}` in its annotation and
  is populated at runtime).
- Settings key: `field.formatter.settings.editablefields_formatter` on a component in
  `core.entity_view_display.<entity>.<bundle>.<mode>` — notable settings: `form_mode`,
  `behaviour` (`inline`|`popup`), `bypass_access`, `fallback_access`/`display_mode_access`,
  `fallback_edit`/`display_mode_edit`, `fields_ajax_trigger`, `fields_ajax_trigger_event`.
- Popup mode uses route `editablefields.get_from` (`/editablefields/get-form/...`) and the
  `core/drupal.dialog.ajax` library.
- Access = `use editablefields` permission AND `update` access to the entity (unless
  `bypass_access` is on). Service: `editablefields.helper`
  (`Drupal\editablefields\services\EditableFieldsHelper`).
