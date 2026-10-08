<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable and configure the icon picker on a text format

There is **no global settings page** (`configure: null`). All configuration is per text
format, stored in the `editor.editor.<format>` config entity.

## Config shape

```yaml
# editor.editor.full_html
format: full_html
editor: ckeditor5
settings:
  toolbar:
    items:
      - bold
      - icon                      # <-- the toolbar button id
  plugins:
    ckeditor5_icons_icon:         # <-- the CKEditor 5 plugin id
      fa_version: '6'             # string '6' or '5'
      fa_styles:                  # sequence of style names
        - solid
        - regular
        - brands
      custom_metadata: false      # true only if the `fontawesome` contrib module is installed
      async_metadata: true        # load the catalogue on demand (recommended)
      recommended_enabled: false
      recommended_icons:          # sequence of icon names, no `fa-` prefix
        - drupal
        - heart
```

Schema: `ckeditor5.plugin.ckeditor5_icons_icon` in `config/schema/ckeditor5_icons.schema.yml`.

## Key reference

| Key | Type | Values / default | Effect |
|---|---|---|---|
| `fa_version` | string | `'6'` (default) or `'5'`; anything else coerces to `'6'` | Picks the bundled metadata set and the class flavour emitted (`fa-solid` vs `fas`) |
| `fa_styles` | sequence | default `[solid, regular, brands]` | Which style tabs the picker offers |
| `custom_metadata` | bool | default `FALSE` | `TRUE` sources icons from the contrib `fontawesome` module instead of the bundled YAML; validation **rejects** `TRUE` when that module is absent |
| `async_metadata` | bool | default `TRUE` | `TRUE` fetches the catalogue from the CSRF-protected metadata route when the picker opens; `FALSE` inlines `faIcons`/`faCategories` into the editor settings |
| `recommended_enabled` | bool | default `FALSE` | Shows the "Recommended" category |
| `recommended_icons` | sequence | form default `drupal,plus,font-awesome,equals,heart` | Icon names for that category; the form lowercases and strips anything outside `[a-z0-9-]` |

Available style names (`CKEditor5Icons::getFontAwesomeStyles()`), with FA-Pro and version
compatibility:

| Style | Pro? | FA versions | FA6 class | FA5 class |
|---|---|---|---|---|
| `solid` | no | 5, 6 | `fa-solid` | `fas` |
| `regular` | no | 5, 6 | `fa-regular` | `far` |
| `light` | **yes** | 5, 6 | `fa-light` | `fal` |
| `thin` | **yes** | 6 only | `fa-thin` | — |
| `duotone` | **yes** | 5, 6 | `fa-duotone` | `fad` |
| `brands` | no | 5, 6 | `fa-brands` | `fab` |
| `custom` | **yes** (Kit) | 5, 6 | `fa-kit` | `fak` |

Form validation errors if a selected style is incompatible with the selected `fa_version`
(e.g. `thin` with `fa_version: '5'`).

## Via the UI

1. *Configuration → Content authoring → Text formats and editors*
   (`/admin/config/content/formats`), **Configure** the format.
2. Drag the **Icons** button from *Available buttons* into the active toolbar.
3. An **Icons** vertical tab appears below; set version, styles, async metadata and the
   Recommended category there.
4. **Save configuration**.

## Via drush (scriptable)

```php
$editor = \Drupal\editor\Entity\Editor::load('full_html');
$s = $editor->getSettings();
if (!in_array('icon', $s['toolbar']['items'], TRUE)) {
  $s['toolbar']['items'][] = 'icon';
}
$s['plugins']['ckeditor5_icons_icon'] = [
  'fa_version' => '5',
  'fa_styles' => ['solid', 'brands'],
  'custom_metadata' => FALSE,
  'async_metadata' => TRUE,
  'recommended_enabled' => TRUE,
  'recommended_icons' => ['drupal', 'heart'],
];
$editor->setSettings($s)->save();
```

Read it back:

```bash
drush cget editor.editor.full_html settings.plugins.ckeditor5_icons_icon
drush cget editor.editor.full_html settings.toolbar.items      # must include `icon`
```

## Gotchas

- **Removing `icon` from the toolbar** makes core drop the whole
  `settings.plugins.ckeditor5_icons_icon` block on the next UI save — the plugin is only
  "enabled" while its toolbar item is present.
- The plugin declares `elements: ['<i>', '<i class>']`, so on a **restricted** format
  (e.g. Basic HTML) adding the button automatically allows those tags through
  `filter_html`. Check `filter.format.<id>` → `filters.filter_html.settings.allowed_html`
  after saving through the UI.
- The module never loads the Font Awesome stylesheet on the front end. Ensure the theme,
  a CDN include, or the `fontawesome` contrib module provides it, and that its major
  version matches `fa_version`.
