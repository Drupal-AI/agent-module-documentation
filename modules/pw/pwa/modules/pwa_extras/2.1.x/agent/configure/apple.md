# PWA Extras (Apple/iOS) settings

Config object **`pwa_extras.settings.apple`**; form route `pwa_extras.settings` →
`/admin/config/pwa/pwa_extras` (permission `administer pwa`).

| Key | Type | Default | Meaning |
|---|---|---|---|
| `touch_icons` | map of checkboxes | `{touch-icon-default:0, touch-icon-mask:0}` | Which apple-touch-icon links to emit (incl. the pinned-tab mask icon) |
| `mask_color` | string (hex) | `#0678be` | Color of the Safari pinned-tab mask icon (shown when `touch-icon-mask` is on) |
| `meta_tags` | map of checkboxes | `{meta-capable:0, meta-status-bar-style:0, meta-app-title:0}` | Which Apple meta tags to emit (web-app-capable, status-bar-style, app title) |
| `color_select` | string | `default` | Status-bar style: `default`, `black`, or `black_translucent` |
| `home_screen_icons` | map of checkboxes | iPhone/iPad splash keys, all `0` | Which add-to-home-screen splash icons to emit |

The checkbox maps store `0`/`1` (or the option key) per option; helper functions
(`pwa_extras_apple_touch_icons()`, `pwa_extras_apple_meta_tags()`,
`pwa_extras_apple_home_screen_icons()`) supply the option lists, and
`pwa_extras_page_attachments()` renders the selected tags.

```bash
drush cget pwa_extras.settings.apple mask_color
drush cset pwa_extras.settings.apple mask_color '#ff0000' -y
drush cset pwa_extras.settings.apple color_select black_translucent -y
```

```php
\Drupal::configFactory()->getEditable('pwa_extras.settings.apple')
  ->set('color_select', 'black')
  ->save();
```
