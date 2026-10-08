# Configure CKEditor Font

There is **no dedicated settings form** (`configure` is null). All configuration is
per text format, stored in the editor entity's `settings.plugins`. Config schema lives at
`config/schema/ckeditor_font.schema.yml`.

## Enable the buttons

1. Go to **Admin → Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`, route `filter.admin_overview`).
2. **Configure** a format that uses the **CKEditor 5** editor.
3. In **Toolbar configuration**, drag the buttons from *Available* into the *Active toolbar*:
   - **Font Family** (`fontFamily`) and **Font Size** (`fontSize`) — from the `ckeditor_font_font` plugin.
   - **Font Color** (`fontColor`) — `ckeditor_font_font_color`.
   - **Font Background Color** (`fontBackgroundColor`) — `ckeditor_font_font_background_color`.
4. Plugin settings appear below the toolbar once a button is active. Fill them in and **Save**.

Each plugin declares its allowed elements as `<span>` and `<span style>`, so CKEditor 5
adds those to the format's allowed HTML automatically — no manual filter edit needed for
the inline styles to survive.

## Font Size & Family plugin (`ckeditor_font_font`)

| Setting | Key | Notes |
|---|---|---|
| Font sizes | `font_sizes` | Textarea, one per line: `123px|Size label` (also `em`, `%`, `pt`, `rem`, or CSS keywords like `small`/`large`). Label optional. Empty → defaults `tiny, small, default, big, huge`. |
| Support all Font Size values | `supportAllSizeValues` | Checkbox. When on, pasted font-size values outside the list are kept (values must be numeric); cannot be enabled with an empty size list. |
| Font families | `font_names` | Textarea, one per line: `Primary, fallback1, fallback2`. Label is derived from the first family. Empty → a built-in serif/sans-serif/monospace default list. |
| Support all Font Family values | `supportAllFamilyValues` | Checkbox. When on, pasted font-family values outside the list are kept instead of stripped. |

Size syntax is validated (`123px|Size label`); a bad line raises "The provided list of font
sizes is syntactically incorrect." Families with a legacy `|label` suffix are accepted (the
label is stripped).

## Font Color (`ckeditor_font_font_color`) and Font Background Color (`ckeditor_font_font_background_color`)

Both share the same shape:

| Setting | Key (color) | Key (background) | Notes |
|---|---|---|---|
| Colors | `font_colors` | `font_backgroundcolors` | Textarea, one per line: `rgb(255,255,255)|Label`, `hsl(0,0%,0%)|Label`, or `#ff0000|Label`. Invalid syntax raises an error. |
| Number of columns | `columns` | `columns` | Integer, min 1, default 5 — columns in the swatch dropdown. |
| Maximum available colors | `documentColors` | `documentColors` | Integer, min 0, default 0 — recently-used "document colors"; `0` disables that feature. |

## Deploying config

Settings are part of the editor entity (`editor.editor.<format>`). Export/import with
`drush config:export` / `config:import` like any other config.

## CKEditor 4 → 5 upgrade

A `CKEditor4To5Upgrade` plugin (`ckeditor_font`) maps the old CKEditor 4 `Font` button →
`fontFamily`, `FontSize` → `fontSize`, and converts the old `font` plugin's `font_sizes` /
`font_names` settings into the `ckeditor_font_font` plugin config during format upgrade.
