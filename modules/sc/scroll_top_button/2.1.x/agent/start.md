# Scroll To Top Button — agent index

Adds a customizable "scroll to top" button to the site front end. Pure config + a jQuery library;
no block, plugin, permission of its own, or PHP API. All state is one config object,
`scroll_top_button.settings`, edited at `/admin/config/user-interface/scroll_top_button`.

- **Settings form, every config key, the `enabled` string gotcha, and how it's applied** →
  [configure/settings.md](configure/settings.md)

Key facts: route `scroll_top_button.settings` is gated by core **`administer site configuration`**
(the module ships no permissions). The `enabled` key is the **string** `'on'`/`'off'` (not a
boolean). Config keys: `enabled`, `show_on_admin`, `button_text`, `button_style`
(`image|link|pill|tab`), `button_animation` (`fade|slide|none`), `button_animation_speed`,
`scroll_distance`, `scroll_speed`.
