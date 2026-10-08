# Settings

![External Links settings form](../../../../../../../screenshots/extlink/3.0.x/settings.png)

Single config object `extlink.settings` (schema `config/schema/extlink.schema.yml`, defaults
`config/install/extlink.settings.yml`). UI at `/admin/config/user-interface/extlink`
(route `extlink_admin.settings`, form `ExtlinkAdminSettingsForm`, permission
`administer extlink`). Read/write with `drush config:get extlink.settings` /
`drush config:set extlink.settings <key> <value>`.

Keys (all `extlink_*`), grouped:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `extlink_class` | string | `ext` | CSS class / icon added to external links (empty = no icon). |
| `extlink_mailto_class` | string | `mailto` | Icon class for `mailto:` links. |
| `extlink_tel_class` | string | `tel` | Icon class for `tel:` links. |
| `extlink_label` / `extlink_mailto_label` / `extlink_tel_label` | label | `(link is external)` etc. | Assistive-tech alt text per link type. |
| `extlink_target` | bool | false | Open external links in a new tab. |
| `extlink_target_no_override` / `extlink_title_no_override` / `extlink_follow_no_override` | bool | false | Keep existing `target`/`title`/`rel` if already set. |
| `extlink_target_display_default_title` | bool | true | Append the new-window notice text. |
| `extlink_target_default_title_text` | text | `(opens in a new window)` | That notice text. |
| `extlink_nofollow` | bool | false | Add `rel="nofollow"`. |
| `extlink_noreferrer` | bool | true | Add `rel="noreferrer"`. |
| `extlink_exclude_noreferrer` | string | `''` | Regex of links to skip for noreferrer. |
| `extlink_subdomains` | bool | true | Treat subdomains as internal. |
| `extlink_alert` / `extlink_alert_text` | bool / text | false / warning msg | Confirmation pop-up before leaving. |
| `extlink_img_class` | bool | false | Treat image-wrapped anchors as external. |
| `extlink_hide_icons` | bool | false | Hide decorative icons from screen readers. |
| `extlink_exclude` / `extlink_include` | string | `''` | Regex of hrefs to skip / restrict to. |
| `extlink_css_exclude` / `extlink_css_include` / `extlink_css_explicit` | string | `''` | CSS selectors to skip / restrict / force. |
| `extlink_additional_link_classes` / `_mailto_` / `_tel_classes` | string | `''` | Extra classes added per link type. |
| `extlink_icon_placement` | string | `append` | `append` or `prepend` the icon. |
| `extlink_prevent_orphan` / `_text_like` | bool | true | Keep icon on the same line as last word. |
| `extlink_use_font_awesome` + `extlink_font_awesome_classes` | bool + mapping | false | Use Font Awesome classes for icons. |
| `extlink_use_icon` + `extlink_icons` | bool + mapping | false | Use UI Icons packs (needs `ui_icons`). |
| `extlink_exclude_admin_routes` | bool | false | Disable processing on admin routes. |
| `extlink_use_external_js_file` | bool | false | Serve settings from cacheable `/extlink/settings.js` instead of inline `drupalSettings`. |
| `allowed_domains` | sequence | `[]` | Extra domains treated as internal. |

Delivery: `hook_page_attachments` attaches library `extlink/drupal.extlink` and injects the
above as `drupalSettings.data.extlink` — unless `extlink_use_external_js_file` is on, in which
case the values are served from the `/extlink/settings.js` route. Saving config auto-flushes
the JS asset caches (event subscriber). Config is translatable
(`extlink.config_translation.yml`).
