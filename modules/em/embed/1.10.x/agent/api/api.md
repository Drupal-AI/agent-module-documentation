# Embed API

Programmatic surface for embed integrations.

**Services**
- `plugin.manager.embed.type` (`EmbedTypeManager`) — discover/instantiate `EmbedType`
  plugins: `getDefinitions()`, `createInstance($id, $config)`.
- `access_check.embed_button_editor` (`EmbedButtonEditorAccessCheck`) — route access via
  `_embed_button_editor_access`, checks a button is allowed in a given text format/editor.

**Preview endpoint**
- Route `embed.preview` → `/embed/preview/{filter_format}` (`EmbedController::preview`),
  access `_entity_access: filter_format.use`. Returns rendered embed markup for the editor
  dialog via AJAX.

**AJAX insert**
- `Drupal\embed\Ajax\EmbedInsertCommand` — AJAX command that inserts returned markup into
  the CKEditor instance.

**Base classes / helpers**
- `EmbedCKEditorPluginBase` — base for CKEditor 4 button plugins.
- `Plugin/CKEditor5Plugin/EmbedCKEditor5PluginBase` + `Deriver/EmbedCKEditor5PluginDeriver`
  — CKEditor 5 integration; buttons derived from `embed_button` entities.
- `DomHelperTrait` — utilities for manipulating embed markup in the DOM during filtering.
- `Entity/EmbedButton` (`EmbedButtonInterface`) — the config entity; read `type_id`,
  `type_settings`, icon, and the instantiated `EmbedType` plugin.

See also [plugins/embed-type.md](../plugins/embed-type.md) for defining an embed type.
