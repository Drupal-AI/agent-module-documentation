# Configure CKEditor Tooltips

Two parts: (1) enable the toolbar button on a text format, (2) tune global Tippy behaviour on the
settings form. The settings are global — they apply to every tooltip on the front end, not per format.

## 1. Enable the button on a format

1. Go to *Configuration → Content authoring → Text formats and editors*
   (`/admin/config/content/formats`) and edit a CKEditor 5 format.
2. Drag the **CKEditor Tooltips** icon from *Available* into the **Active toolbar**.
3. Save. The format's allowed HTML is extended with the tooltip spans (see below).

The plugin (`ckeditor_tooltips.ckeditor5.yml`) declares these allowed elements on the format:
`<span>`, `<span data-tippy-content>`, `<span data-tooltip-title>`, `<span data-tooltip-content>`,
`<span data-tooltip-data>`, `<span data-tooltip-placeholder-is-selection>`,
`<span data-tooltip-placeholder-is-selection-text>`, `<span class="ckeditor-tooltip-text">`.

Editors then select text and click the icon to enter tooltip content (or click with no selection to
drop a default "i" info icon). The content is saved into the field HTML as a `data-tippy-content`
span.

## 2. Global settings form

Route `ckeditor_tooltips.settings` → `/admin/config/content/ckeditor-tooltips`
(permission `administer ckeditor tooltips`). Config object `ckeditor_tooltips.settings`.
Defaults from `config/install/ckeditor_tooltips.settings.yml`:

| Key | Type | Default | Meaning (maps to Tippy option) |
|---|---|---|---|
| `follow_cursor` | radios | `'0'` | Tooltip follows cursor: `0`/Default, `initial`, `1` (both axes), `horizontal`, `vertical`. |
| `prevent_overflow` | checkbox | `0` | Adds Popper `preventOverflow` modifier (`altAxis`). |
| `allow_html` | checkbox | `1` | Render tooltip content as **HTML** (Tippy `allowHTML`). On by default. |
| `interactive` | checkbox | `1` | Tooltip is hoverable/clickable without hiding (Tippy `interactive`). |
| `max_width` | number | `'500'` | Tooltip max width (Tippy `maxWidth`). |
| `skidding` | number | `'0'` | Offset skidding (Tippy `offset[0]`). |
| `distance` | number | `'15'` | Offset distance (Tippy `offset[1]`). |
| `trigger` | radios | `click` | Show event: `click`, `mouseenter`, `manual`, `focus`, `focusin`. |
| `animations` | radios | `scale` | `none`, `fade`, or `scale`. |
| `custom_styling` | checkbox | `0` | When on, the module's bundled front-end CSS + tippy-overrides are **not** attached, so a theme can style tooltips. |

Note: `interactive`, `allowHTML`, `maxWidth`, `trigger`, `animation` are all mapped verbatim into
`drupalSettings.ckeditor_tooltips` for the JS. `inertia` is always TRUE.

## Front-end attach flow (`ckeditor_tooltips.module`)

`hook_page_attachments_alter()` runs on every page and:

- Always attaches library `ckeditor_tooltips/tippyjs` (Tippy 6.3.7 + Popper, bundled under
  `js/vendor`, no CDN) and `ckeditor_tooltips/front-end-js`.
- Attaches the scale animation CSS when `animations` is empty or `scale`.
- Attaches the bundled styling (`front-end-styling` + `tippy-overrides`) **unless** `custom_styling`
  is set.
- Builds `drupalSettings.ckeditor_tooltips` from the config (followCursor, interactive, allowHTML,
  maxWidth, trigger, offset `[skidding, distance]`, animation, inertia, optional Popper
  `preventOverflow`).

`js/ckeditor_tooltips.js` then initialises Tippy on the tagged spans using those settings.

## Gotchas

- **No config schema** ships (`ckeditor_tooltips` has `config/install` but no `config/schema/`; the
  README lists "Sanitize entered text if needed" and schema as TODOs). This can trigger schema
  checker warnings in tests and means values are stored untyped (several are stored as strings, e.g.
  `follow_cursor: '0'`, `max_width: '500'`).
- Settings are global, not per-format — you cannot vary tooltip behaviour between two formats.
- If you toggle `custom_styling`, clear caches so the attached libraries update.
