<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Image Hover Effects adds two field formatters — "Image with hover effect" and "Responsive image with hover effect" — that wrap the core image formatters with a selectable CSS hover animation (zoom, overlay, fade/zoom-in variants) and an optional overlay caption that supports tokens. Effects only apply when the image is a link.

---

The module ships two `@FieldFormatter` plugins that subclass core's `ImageFormatter` and `ResponsiveImageFormatter` and share a `FormatterTrait`. On top of the standard image-formatter settings each adds two options: a **Image Hover Effect** select (`hover_effect`) and a **Hover text** textarea (`hover_text`). Both are wrapped in `#states` that hide them unless the formatter's core **Link image to** (`image_link`) setting is non-empty — the effects are CSS `:hover` rules on the wrapping `<a>`, so with no link there is nothing to attach them to. At render time `updateElements()` swaps in one of two module templates and sets `link_attributes` on the anchor: a base class `ihe-overlay` plus `ihe-overlay--{effect}` (run through `Html::getClass()`), and a `data-hover` attribute holding the token-replaced hover text. The CSS library (`css/image-hover-effects.css`, attached automatically) does the rest: an `::after` pseudo-element renders `content: attr(data-hover)` as a centred caption, and an `::before` element draws the dark overlay; the eight effects are `zoom`, `default` (Overlay), `fade_in`, `zoom_in`, `fade_in_down`, `fade_in_up`, `fade_in_left`, `fade_in_right`. If the **Token** module is enabled, a token-tree browser appears under the Hover text field for the formatter's target entity type. There is no admin config page, no permission, and no config schema — everything is per-display formatter settings on Manage display (and works identically for Views fields). Depends on core `image` **and** `responsive_image`; version 2.0.2 runs on `^8.8 || ^9 || ^10 || ^11`. Package is `Sooperthemes` (a commercial theme vendor / DXPR), though the module is GPL. Two practical caveats: hover does not exist on touch devices, so any effect that reveals a caption rather than merely decorating needs a non-hover fallback; and the caption is rendered by CSS `content`, so it is plain text only — line breaks and markup in the hover text are not honoured.

---

- Add a zoom-on-hover effect to card or teaser images.
- Fade a dark overlay in over an image on hover.
- Reveal a caption over an image when the user hovers.
- Show `[node:title]` (or another token) as the hover caption.
- Configure a hover effect per view mode / display.
- Apply the same effect to a Responsive Image field.
- Use a hover effect on an image field rendered in a View.
- Avoid writing and deploying per-project hover CSS.
- Standardise image hover behaviour across displays via exportable config.
- Let a site builder pick an effect without touching a theme.
- Add a slide-in overlay (fade in down / up / left / right).
- Add a zoom-in overlay that scales in from the centre.
- Give a product grid a consistent motion treatment.
- Add polish to a listing or gallery page.
- Differentiate a featured image with a stronger effect.
- Pair a hover caption with a link to the linked content.
- Add a subtle image transition on portfolio thumbnails.
- Keep hover effects in exported configuration rather than templates.
- Provide a call-to-action caption ("Read more") over a linked image.
- Match a design comp's hover states without custom front-end work.
