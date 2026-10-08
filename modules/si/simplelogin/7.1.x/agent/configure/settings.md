# Simple Login settings

- Config object: **`simplelogin.settings`**
- Form: `/admin/config/simplelogin` (route `simplelogin.admin_settings_form`)
- Permission: **`administer site configuration`** (core; the module defines none of its own)

## Keys (defaults = shipped install values)

```yaml
background_active: false        # bool: true = use background_image, false = use background_color
background_image: []            # sequence of managed file IDs (the uploaded image)
background_color: '#00bfff'     # string hex color used when background_active is false (and for buttons)
background_opacity: false       # bool: apply an opacity overlay (only effective with an active image)
button_background: false        # bool: tint submit buttons & links with background_color
wrapper_width: 360              # integer: width (px) of the centered form card
unset_active_css: false         # bool: remove the active theme's CSS from these pages
unset_css: ''                   # string: newline-separated stylesheet paths to remove
visually_hidden_labels: true    # bool: hide form labels (kept for screen readers); fields get placeholders
```

Notes:
- `background_image` is a managed-file field; the runtime helper `simple_login_settings('image')`
  loads file id `background_image[0]` and turns it into a URL.
- When `background_active` is true the page gets `background-image: url(<image>)`; otherwise
  `background-color: <background_color>`.
- `background_color` doubles as the button/link color when `button_background` is on.

## Read / write via drush

```bash
drush cget simplelogin.settings
drush cset simplelogin.settings background_color '#ff8800' -y
drush cset simplelogin.settings wrapper_width 500 -y
drush cset simplelogin.settings background_active 1 -y
```

The runtime accessor `simple_login_settings($key)` (in `simplelogin.module`) wraps these with
fallbacks (color → `#00bfff`, width → `360`, etc.).
