# JSON Form Widget (Basic) — agent index

The simplest concrete widget for JSON Form Widget: paste a JSON Schema (+ optional UI schema) into
a field's *Manage form display* settings and it renders that schema as the field's edit form.
No config page, permissions, or Drush. Depends on `json_form_widget`.

- **Selecting the widget, the two settings textareas, config schema, invalid-schema fallback** → [configure/widget.md](configure/widget.md)

Parent module: [../../../../1.0.x/agent/start.md](../../../../1.0.x/agent/start.md) — see its
`extend/widget.md` for writing a *dynamic*-schema widget instead.

Key facts:
- Plugin: `json_form_widget_basic` (`JsonFormWidgetBasic extends JsonFormWidgetBase`).
- Field types: `json`, `json_native`, `json_native_binary`, `text_long`, `string_long`.
- Settings keys: `json_schema` (required), `ui_schema` (optional); schema `field.widget.settings.json_form_widget_basic`.
- Invalid JSON → `getDefaultSchema()` renders a read-only "Invalid JSON Schema" info field.
