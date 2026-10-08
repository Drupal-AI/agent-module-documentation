# Configure embed buttons

Embed buttons are `embed_button` config entities (`embed.button.*`). Manage at
`/admin/config/content/embed` (route `entity.embed_button.collection`, permission
`administer embed buttons`). Add via `embed.button_add`; edit/delete via
`entity.embed_button.edit_form` / `.delete_form`.

Each button binds:
- `type_id` — an `EmbedType` plugin id (e.g. `entity` from Entity Embed).
- `type_settings` — plugin-specific settings (schema `embed.embed_type_settings.[type_id]`).
- `icon` — uploaded toolbar icon (`uri` + base-64 `data`).

Global settings form (`/admin/config/content/embed/settings`, route `embed.settings`):
`config/install/embed.settings.yml`:
```yaml
file_scheme: public        # scheme for stored button icons
upload_directory: embed_buttons
```

Add a button to an editor by placing it in the text format's CKEditor toolbar (Admin →
Config → Content authoring → Text formats and editors). For CKEditor 5, buttons are derived
automatically (`EmbedCKEditor5PluginDeriver`); the plugin cache is cleared on button save
(`embed_embed_button_presave`). A button is only usable where the format's `use` access and
any `required_filter_plugin_id` are satisfied.
