# Tawk.to — settings, widget picker & visibility

Admin menu root `tawk_to.index` at `/admin/config/services/tawk_to`. Config object
`tawk_to.settings`. Every route requires permission `administer tawk_to settings` (restrict access).

## Config keys (`tawk_to.settings`)
| Key | Type | Default | Meaning |
|---|---|---|---|
| `tawk_to_widget_page_id` | string | `''` | tawk.to property/page id (24 hex chars). |
| `tawk_to_widget_id` | string | `''` | tawk.to widget id (`[a-z0-9]{1,50}`). |
| `visibility` | sequence | `{}` | Map of `condition_plugin_id` → that condition's config (core Condition plugins). |
| `show_user_name` | bool | `false` | Whether to send a visitor name to the widget. |
| `user_name` | string | `[current-user:name]` | Token string for the visitor name. |
| `show_user_email` | bool | `false` | Whether to send a visitor email. |
| `user_email` | string | `[current-user:mail]` | Token string for the visitor email. |
| `script_load_delay` | int (ms) | `0` | Delay before injecting the tawk.to script. |

## Selecting a widget (the iframe flow)
- `/admin/config/services/tawk_to/widget` (`tawk_to.widget`) →
  `TawkToWidgetController::widgetsContent()` renders the `tawk_to_iframe` theme, embedding
  `https://plugins.tawk.to/generic/widgets?currentWidgetId=…&currentPageId=…`. You log in to
  tawk.to inside that iframe and pick a widget.
- The iframe `postMessage`s back; the template's JS POSTs to:
  - `tawk_to.set_widget` → `setWidget()` — validates `pageId` (`/^[0-9A-Fa-f]{24}$/`) and `widgetId`
    (`/^[a-z0-9]{1,50}$/i`); saves both to config. Returns `{success: bool}`.
  - `tawk_to.remove_widget` → `removeWidget()` — clears both IDs.
  - Both honor per-language config overrides when the site is multilingual.

## Extra Settings form (`tawk_to.extra_settings`, `TawkToExtraSettingsForm`)
- Builds a **Visibility** vertical-tabs UI from `plugin.manager.condition` (skips
  `entity_bundle:webform_submission`, `current_theme`, `gtag_language`, and `language` when the site
  isn't multilingual). Saved to `visibility`.
- **User info settings**: `show_user_name` + `user_name` token, `show_user_email` + `user_email`
  token (tokens like `[current-user:name]` / `[current-user:mail]`).
- **Script load delay** (`script_load_delay`, milliseconds).

## Notes
- The widget only renders when both IDs are set and conditions pass — see
  [../api/render.md](../api/render.md).
- `user_name`/`user_email` are token-replaced then printed into an inline `<script>` JS string in
  `templates/tawk-to.html.twig`; Twig HTML-autoescaping neutralizes quote/angle-bracket breakouts.
  `embed_url`/`page_id`/`widget_id` are printed inside `{% autoescape false %}` but are
  admin-set and regex-validated on save.
