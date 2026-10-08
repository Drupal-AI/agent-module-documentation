# Adding & configuring a Background Image field

No global settings — everything is per-field via Field UI. There is no `configure` route and no
permission of the module's own (standard `administer <entity> fields` gates field setup; content
editors set per-item values through the widget).

## 1. Add the field
Field UI → *Manage fields* → add a field of type **Background Image** (`bg_img_field`) to any
entity/bundle. Storage/field settings (from `BgImgItem`):
- **Allowed file extensions** — default `png jpg jpeg svg` (edit to add e.g. `webp`).
- alt/title fields are removed (background images are treated as decorative).
- **CSS Settings** (field-level defaults): `css_selector` (textfield, token-aware),
  `css_repeat`, `css_background_size`, `css_background_position`.

## 2. Widget (content form) — `bg_img_field_widget`
Extends the core Image widget. After a file is uploaded, a **CSS Settings** details element appears
with per-item:
- `css_selector` — textfield (token tree shown; `#token_types` scoped to the host entity type).
- `css_repeat` — radios: `inherit` | `no-repeat` | `repeat`.
- `css_background_size` — radios: `inherit` | `auto` | `cover` | `contain` | `initial`.
- `css_background_position` — radios: 9 positions (`center center`, `left top`, …).

Widget setting **Hide CSS Settings** (`hide_css_settings`) adds a `visually-hidden` class — it
hides the fields in the UI but they remain present and submittable. `massageFormValues()` flattens
`css_settings.*` back onto the item columns on save.

## 3. Formatter (Manage display) — `bg_img_field_formatter`
Extends `ResponsiveImageFormatter`. One setting: **Responsive image style**
(`responsive_image_style`). Only styles whose first mapping is `image_style` (single image style)
are listed; "sizes"/multi styles and the image-link option are removed.

## How the CSS is generated (`viewElements` → `generateBackgroundCss`)
For each file item:
1. `selector = token->replace(item.css_selector, {<entity_type>: entity}, clear:TRUE)`.
2. Base rule: `<selector>{background-repeat:…;background-size:…;background-position:…;}` using the
   item's stored values.
3. For each breakpoint/multiplier in the responsive image style, append
   `@media <query> { <selector> {background-image: url(<image-style-url>);} }`, adding
   device-pixel-ratio queries for multipliers > 1. `"_original image_"` mapping uses the raw file
   URL; otherwise the mapped image style's `buildUrl()`.
4. Output:
   - On Layout Builder routes (`node/<id>/layout`) → `#theme => 'background_style'`
     (`<style>{{ css }}</style>`).
   - Otherwise → attached to `#attached['html_head']` as a `#tag => 'style'` element, id
     `picture-background-formatter-<selector>`.

If no responsive image style is set, it logs an error and emits only the base rule (no image URL).

## Notes / gotchas
- The `css` value is wrapped in `CSSSnippet` (a `MarkupInterface` passthrough).
  `css_repeat/size/position` come from fixed radio options; `css_selector` is free text.
- Config schema keys: `field.formatter.settings.bg_img_field_formatter` (`image_style`) and
  `field.widget.settings.bg_img_field_widget` (`hide_css_settings`, `css_settings.*`).
- The formatter only renders if a responsive image style exists that maps to a single image style;
  create one under *Configuration → Media → Responsive image styles* first.
