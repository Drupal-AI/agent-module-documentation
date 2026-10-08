# Per-section settings

Configured on the section's "Configure section" tray in Layout Builder (not a global form).
Defaults come from `LayoutBgTrait::defaultConfiguration()`; schema
`layout_plugin.settings.layout_bg_onecol` / `..._twocol` in `config/schema/layout_bg.schema.yml`.
Stored on the Layout Builder section, so config export lives with the entity/default layout.

| Setting | Key | Type | Default | Effect |
|---|---|---|---|---|
| Use Static Image | `static_image` | bool | `TRUE` | `TRUE` = background in flow (`static-image` class); `FALSE` = absolute, out of flow (`absolute-image`) |
| Center Content | `center_content` | bool | `FALSE` | only visible when static; adds `center-content` class to center content over the image |
| Background Color | `background_color` | color | `#AAAAAA` | fallback color inline on the background region (shown before/if image fails) |
| Set Text Color | `set_text_color` | bool | `TRUE` | apply an inline text `color` + `set-text-color` class to content |
| Text Color | `text_color` | color | `#FFFFFF` | the text color (visible only when Set Text Color on) |
| Underline Links | `link_underline` | bool | `TRUE` | adds `link-underline` class (visible only when Set Text Color on) |
| Add Overlay | `add_overlay` | bool | `TRUE` | render an overlay `<div>` over the background |
| Overlay Color | `overlay_color` | color | `#000000` | overlay background color (visible only when Add Overlay on) |
| Overlay Opacity | `overlay_opacity` | number 0–1 step .05 | `0.3` | overlay opacity (0 opaque … 1 transparent, per the field help) |

`layout_bg_twocol` also inherits the core two-column setting `column_widths` (from
`TwoColumnLayout`); the trait re-applies the `layout--twocol-section--<column_widths>` class.

## Using it (editor flow)
1. Enable Layout Builder for the entity view display.
2. Add a section and pick "One-Column Layout with Background Region" (category *Columns: 1*) or
   "Two-Column Layout with Background Region" (category *Columns: 2*).
3. Add a block to the **Background** region — usually a field block for an image/media field, with
   any formatter that outputs an `<img>` (image, responsive image, Blazy, media thumbnail). Only the
   first non-empty block renders.
4. Add your content to the `content` (or `first`/`second`) region.
5. Configure the section to set colors/overlay/text as above.
