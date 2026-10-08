<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Submodule of Combined image style: responsive <picture> field formatters for image and media fields that build per-breakpoint srcset entries from combined image styles.

---

Combined image style formatters adds two field formatters — one for `image` fields ("Responsive image
(Combined image style)") and one for media `entity_reference` fields ("Responsive media (Combined
image style)") — that render a `<picture>` element with a `<source>` per breakpoint. In the
formatter settings you choose a breakpoint group and, for each breakpoint and pixel-density
multiplier, one or more image styles to combine; the formatter builds an in-memory `CombinedImageStyle`
per candidate and uses its generated URL as a `srcset` entry, so each `<source>` offers combined
derivatives at multiple resolutions. It also lets you set a required fallback image style and the
native image `loading` attribute (`lazy`/`eager`). It requires core's Responsive image module and the
parent Combined image style module, and provides no permissions or configuration page of its own.

---

- Render image and media fields as a responsive `<picture>` with a `<source>` per breakpoint.
- Build `srcset` candidates from combined image styles chosen per breakpoint and multiplier.
- Support multiple "Style N" sets combined together for each breakpoint/multiplier slot.
- Choose the breakpoint group in the formatter settings (AJAX-driven form).
- Add or remove style sets dynamically with Add style / Remove style buttons.
- Require a fallback image style rendered via the core `image_style` theme.
- Set the native `loading` attribute to lazy or eager for the fallback image.
- Set a single `<source>` `type` when all its candidates share one MIME type.
- Resolve media entity source image fields (alt/width/height/title) for the media formatter.
- Merge cache tags from every combined style used in the output.
- Work only alongside the parent Combined image style module and core Responsive image.
