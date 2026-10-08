<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drop-in replacement for the core image-style system that generates one derivative from the combined effects of several image styles, addressed by a hyphen-joined style-id folder name.

---

Combined image style lets a single derivative image apply the effects of **multiple core image
styles** at once. Rather than the folder segment naming one style, the derivative URL names a
hyphen-joined list of style ids (e.g. `square-thumbnail`); on delivery the module merges every listed
style's image effects, in order, into one pipeline and writes a single derivative. It works as a
drop-in alongside core: it swaps the `image_style` entity class for a subclass and rewrites core's
public derivative route to a `deliverCombined` controller, while normal per-style derivatives keep
working. The point is to avoid a combinatorial explosion of styles — keep small building-block styles
(three crops × three sizes) and combine them on demand (6 styles instead of 9) rather than
pre-defining every pairing.

For developers the entry point is the fluent `CombinedImageStyle` object: set a source URI and a list
of styles, then call `toImage()` (render array), `buildCombinedUri()` (URI, generated on demand), or
`buildCombinedUrl()` (absolute URL with the security token). The delivery route inherits core's
**itok** token model unchanged — each combined URL carries a hyphen-joined set of per-style HMAC
tokens, so derivatives can't be forced without the site key. Editing a building-block style flushes
every combined derivative built from it. An optional submodule, **Combined image style formatters**,
adds responsive `<picture>` field formatters so combined styles can be used from a field's *Manage
display* without code. The module ships no permissions, no configuration form, and no drush commands;
it is a media/display feature with no access-control role.

---

- Generate one image derivative from the merged effects of several core image styles.
- Address a combined derivative by a hyphen-joined list of style ids (`square-thumbnail`).
- Keep small building-block styles and combine them on demand instead of pre-defining every pairing.
- Act as a drop-in replacement: normal core image styles and derivatives keep working unchanged.
- Build combined derivatives from code with the fluent `CombinedImageStyle` API.
- Return a ready render array for a combined derivative via `toImage()`.
- Return the combined derivative URI (generated on demand) via `buildCombinedUri()`.
- Return the absolute combined derivative URL, with security token, via `buildCombinedUrl()`.
- Merge each listed style's image effects, in list order, into a single effect pipeline.
- Inherit core's itok anti-DDoS token model, emitting per-style HMAC tokens joined by hyphens.
- Cache computed derivative dimensions in a dedicated `image_dimensions` cache bin.
- Flush every combined derivative that references a building-block style when that style changes.
- Swap the core `image_style` entity class for a subclass via `hook_entity_type_build`.
- Rewrite the core `image.style_public` route to the module's `deliverCombined` controller.
- Register a `combined_image_style_responsive_image` theme hook rendering a `<picture>` element.
- Offer responsive image and media field formatters through the optional formatters submodule.
- Require core's Image module (used implicitly; not declared in info.yml).
- Support Drupal 10.2, 11, and 12.
- Add no permissions, no configuration page, and no drush commands.
