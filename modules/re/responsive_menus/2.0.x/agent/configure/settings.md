<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings — `responsive_menus.configuration`

Form: `Drupal\responsive_menus\Form\ResponsiveMenusAdminForm` (route `responsive_menus.admin`,
path `/admin/config/user-interface/responsive_menus`, permission `administer responsive menus`).
Config object: **`responsive_menus.configuration`**.

## Config keys (shipped defaults)

```yaml
style: responsive_menus_simple   # the active @ResponsiveMenus plugin id
ignore_admin: true               # skip admin routes (router.admin_context)
style_settings: {}               # settings for the active style (shape depends on the style)
```

Only **one** style is active site-wide. Changing `style` swaps which plugin runs; `style_settings`
holds that style's own configuration (selectors, toggle text, breakpoint, …).

## Read / write with drush

```bash
drush cget responsive_menus.configuration
drush cset responsive_menus.configuration style mean_menu -y
# Set the Simple style's selectors + breakpoint:
drush php:eval '$c=\Drupal::configFactory()->getEditable("responsive_menus.configuration");
$c->set("style","responsive_menus_simple");
$c->set("style_settings",["responsive_menus_css_selectors"=>"#block-mainnavigation","responsive_menus_media_size"=>900]);
$c->save();'
```

## `style_settings` for the two enabled styles

**Simple** (`responsive_menus_simple`) keys (defaults):
`responsive_menus_simple_absolute` (1), `responsive_menus_disable_mouse_events` (0),
`responsive_menus_remove_attributes` (1), `responsive_menus_css_selectors` (`#main-menu`),
`responsive_menus_simple_text` (`☰ Menu`), `responsive_menus_media_size` (768),
`responsive_menus_media_unit` (`px`).

**Mean Menu** (`mean_menu`) keys (defaults): `responsive_menus_mean_menu_css_selectors` (`#main-menu`),
`responsive_menus_mean_menu_container` (`body`), `responsive_menus_mean_menu_trigger_txt`
(`<span /><span /><span />`), `responsive_menus_mean_menu_close_txt` (`X`),
`responsive_menus_mean_menu_position` (`right`), `responsive_menus_mean_menu_media_size` (480),
`responsive_menus_mean_menu_show_children` (1), `responsive_menus_mean_menu_expand_children` (1),
`responsive_menus_mean_menu_remove_attrs` (1), plus close/expand/contract text keys.

Selector strings accept comma- **or** newline-separated CSS/jQuery selectors (the Simple style
splits them via `getSettingArray()`).

## Runtime

`responsive_menus_page_attachments()` skips admin routes when `ignore_admin` is on, then
instantiates the `style` plugin with `['settings' => style_settings]`, attaches the plugin's
`library`, and writes `getJsSettings()` (plus `responsive_menus_style`) into
`drupalSettings.responsive_menus`.
