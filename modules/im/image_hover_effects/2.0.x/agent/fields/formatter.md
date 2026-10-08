<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the hover-effect formatters

Two formatters are provided; both are configured on **Manage display** (or a Views field), never
on a global settings page.

## Where
- Entity display: `admin/structure/types/manage/<bundle>/display` (and per view mode) for an
  **Image** field.
- Views: the field's **Format** settings when adding an image field to a view.

## Which formatter to pick
- **Image with hover effect** (`image_hover_effects_image`) — for a plain Image field; extends
  the core "Image" formatter, so it keeps Image style + Link image to.
- **Responsive image with hover effect** (`image_hover_effects_responsive_image`) — for use with a
  responsive image style; extends the core "Responsive image" formatter.

## Settings
Both add these to the normal image-formatter settings:

1. **Link image to** (core `image_link`) — MUST be set to *Content* or *File*. The hover settings
   below stay hidden (`#states`) while this is *Nothing*, because the effect is CSS on the
   wrapping `<a>` and there is no anchor without a link.
2. **Image Hover Effect** (`hover_effect`) — one of: *None*, Zoom, Overlay, Overlay fade in,
   Overlay zoom in, Overlay fade in down/up/left/right. (Internal values: `zoom`, `default`,
   `fade_in`, `zoom_in`, `fade_in_down`, `fade_in_up`, `fade_in_left`, `fade_in_right`.)
3. **Hover text** (`hover_text`) — optional caption shown centred over the image on hover.
   Supports tokens for the field's target entity type, e.g. `[node:title]`. With the **Token**
   module enabled, a token-tree browser is shown under the field. Rendered by CSS
   `content: attr(data-hover)`, so it is **plain text only** — HTML and line breaks are ignored.

## Result markup / styling hooks
```
<a class="ihe-overlay ihe-overlay--<effect>" data-hover="<caption>" href="<url>">
  <img …>  {# or the <picture> for responsive #}
</a>
```
- Override look-and-feel by targeting `.ihe-overlay` / `.ihe-overlay--<effect>` and its
  `::before` (overlay) / `::after` (caption) pseudo-elements. The bundled CSS uses a black 20%
  overlay and a 4em white caption.
- The library `image_hover_effects/image_hover_effects` (component CSS) is attached automatically
  whenever a hover formatter renders.

## Notes
- No permission gates this — any role that can edit the display configuration can set it.
- Multi-value image fields get the effect applied to each delta.
- Settings summary shows the chosen effect and hover text on the Manage display row (only when a
  link is configured).
