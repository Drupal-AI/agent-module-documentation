# Tawk.to Live Chat — agent index

Embeds the tawk.to chat widget in the page footer (`hook_page_bottom` → lazy builder), gated by
core Condition plugins. All admin routes require `administer tawk_to settings` (restrict-access).
No Drush, no plugin types of its own; config object `tawk_to.settings`.

- **Settings keys, the widget-picker iframe, the visibility/extra-settings form, routes** →
  [configure/settings.md](configure/settings.md)
- **`TawkToEmbedRender` render service, condition handler, cache manager (programmatic rendering)** →
  [api/render.md](api/render.md)

Key facts:
- Config `tawk_to.settings`: `tawk_to_widget_page_id`, `tawk_to_widget_id`, `visibility` (sequence of condition.plugin config), `show_user_name`/`user_name`, `show_user_email`/`user_email` (token strings, default `[current-user:name]`/`[current-user:mail]`), `script_load_delay` (ms).
- Routes (all `administer tawk_to settings`): `tawk_to.index`, `tawk_to.widget` (picker iframe), `tawk_to.set_widget` / `tawk_to.remove_widget` (POST callbacks, IDs regex-validated), `tawk_to.extra_settings` (visibility + user + delay form).
- Widget renders `https://embed.tawk.to/<pageId>/<widgetId>` only when both IDs are set AND `TawkToConditionPluginsHandler::checkAccess()` (AND over configured conditions) passes.
- Services: `tawk_to.embed_render`, `tawk_to.condition_plugins_handler`, `tawk_to.cache_manager`.
