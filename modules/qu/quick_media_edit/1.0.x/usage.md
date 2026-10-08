<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Quick Media Edit

Quick Media Edit is a tiny helper that improves the editorial workflow around image/media
fields. It implements `hook_preprocess_image_formatter()` and, when the rendered image links
to an edit route the current user may access, it appends the current page path as a
`destination` query parameter. After an editor finishes editing the media/image they are
returned to the page they started from instead of a generic listing.

The module has no configuration UI, no routes, no services and no permissions of its own — it
is purely a preprocess-layer enhancement. If the current user has no access to the URL on the
image formatter, the link is removed entirely, so it never exposes an edit link to users who
could not use it.

---

## Installation & configuration

- Requires the core `media` and `image` modules.
- Install with `drush en quick_media_edit`. There is nothing to configure.
- The behaviour only fires for image formatters that already attach a `url` (e.g. an image
  configured to link to its content/edit route).
- Access to the edit link is checked with `$url->access(\Drupal::currentUser())` before the
  `destination` parameter is set, so no privilege escalation is introduced.

---

## Use cases

- Speed up editorial workflows where staff frequently edit images shown on a page.
- Return editors to the exact page they were viewing after saving a media edit.
- Provide a "return-to" destination automatically without configuring redirects.
- Keep contextual edit links working while adding a destination round-trip.
- Avoid sending editors to a generic media library after an edit.
- Remove edit links for users who lack access, tightening the rendered output.
- Complement core Media Library with a lighter inline-edit affordance.
- Use on landing pages built from many image fields to make each image editable in place.
- Reduce clicks for content teams maintaining large image-heavy sites.
- Pair with the image formatter "Link image to: Content" setting.
- Apply site-wide with zero configuration overhead.
- Serve as a reference implementation of `hook_preprocess_image_formatter()`.
- Keep the destination logic consistent with core's `destination` query handling.
- Improve UX for multi-step editorial review of imagery.
- Avoid custom theme overrides just to add a return path to image edit links.
- Safely no-op on formatters that do not expose a URL.
