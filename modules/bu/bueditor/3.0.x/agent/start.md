# BUEditor — agent index

Customizable text editor attached via core `editor` (an `@Editor` plugin). Define editors,
toolbars, and custom buttons for HTML/Markdown/Textile. Managed at `/admin/config/content/bueditor`
(`configure` → `bueditor.admin`). Two config entities + one plugin type.

- **Editor & button config entities, toolbar, text-format association, `bueditor.settings` (devmode), routes** → [configure/editors.md](configure/editors.md)
- **The `bueditor_plugin` plugin type (`@BUEditorPlugin`) — buttons + JS/form alters; `Core`/`XPreview` plugins** → [plugins/bueditor-plugin.md](plugins/bueditor-plugin.md)
- **Permissions: `administer bueditor` (restricted) and `access ajax preview` + the `/xpreview` endpoint** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config entities: `bueditor_editor` (config prefix `editor`) and `bueditor_button` (config prefix `button`); custom button ids auto-prefixed `custom_`.
- Plugin type `bueditor_plugin`: manager `BUEditorPluginManager`, namespace `Plugin/BUEditorPlugin`, annotation `@BUEditorPlugin` (id/label/weight), interface `BUEditorPluginInterface`.
- A BUEditor instance is chosen per **text format** (core Editor framework), not via a field widget.
- `bueditor.settings` has one key: `devmode` (bool) → loads un-minified BUE lib via `hook_library_info_alter`.
