# Global settings

Form `Drupal\collapsiblock\Form\CollapsiblockGlobalSettings` (`ConfigFormBase`, form id
`collapsiblock_global_settings`). Route `collapsiblock.global_settings` →
`admin/config/user-interface/collapsiblock`, permission `administer site configuration`
(also the module's `configure:` link and a menu link under `system.admin_config_ui`). Edits the
single config object `collapsiblock.settings`.

## Config object `collapsiblock.settings`

| Key | Type | Default (`config/install`) | Meaning |
|---|---|---|---|
| `default_action` | integer | `1` | Site-wide default collapse behavior for blocks left at "Global default". See action codes below. |
| `active_pages` | boolean | `FALSE` | If TRUE, a (menu) block whose body contains an active-trail link (`a.is-active`) may still be collapsed on load. If FALSE, such blocks are forced open on load. |
| `slide_speed` | integer | `200` | Open/close animation duration in ms. Form offers 50–1300. |
| `cookie_lifetime` | float (nullable) | `null` | Cookie lifetime in **days** (fractions allowed, e.g. `0.5` = 12h). Blank/`null` = session cookie. A **negative** value (e.g. `-1`) means "do not store a cookie at all" (e.g. GDPR). |
| `switcher_enabled` | boolean | `FALSE` | Enable the collapse-arrow dark-mode color switcher. |
| `switcher_class` | string | `''` | CSS class present at the top of the DOM only when the theme is in dark mode; when found, the toggle button gets class `collapsiblock-color-switcher`. Required in the form when `switcher_enabled` is checked. |

Schema: `config/schema/collapsiblock.schema.yml` (`collapsiblock.settings` as `config_object`).

## Action codes (`CollapsiblockGlobalSettings::ACTION_OPTIONS`)

| Code | Label | Behavior | Cookie? |
|---|---|---|---|
| `1` | None | Block is not collapsible. | no |
| `2` | Collapsible, expanded by default | Toggleable; starts expanded unless the cookie says otherwise. | yes |
| `3` | Collapsible, collapsed by default | Toggleable; starts collapsed unless the cookie says otherwise. | yes |
| `4` | Collapsible, collapsed all the time | Toggleable; always starts collapsed. | no |
| `5` | Collapsible, expanded all the time | Toggleable; always starts expanded. | no |

`default_action` uses these same codes. Per-block/Layout-Builder settings add a code `0` meaning
"use the global `default_action`". Only `default_action` values `2`–`5` produce collapsible markup
(`1` = no wrapper).

## Set it with Drush / PHP

```php
\Drupal::configFactory()->getEditable('collapsiblock.settings')
  ->set('default_action', 3)      // collapsed by default site-wide
  ->set('active_pages', FALSE)
  ->set('slide_speed', 200)
  ->set('cookie_lifetime', 30)    // remember for 30 days; null = session; -1 = no cookie
  ->set('switcher_enabled', FALSE)
  ->set('switcher_class', '')
  ->save();
```

```bash
drush config:set collapsiblock.settings default_action 3 -y
drush config:set collapsiblock.settings cookie_lifetime 30 -y
```

`hook_page_attachments_alter()` pushes `active_pages`, `slide_speed`, `cookie_lifetime`,
`switcher_enabled`, `switcher_class` to `drupalSettings.collapsiblock` for the JS on every page.
