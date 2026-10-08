<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Image Compare Viewer (icm) adds an "Image Compare Viewer" field formatter for image fields so the images uploaded to a multi-value image field render as an interactive before/after comparison slider that visitors drag or tap.

The formatter (`IcmFieldFormatter`, extending `ImageFormatterBase`) collects the field's referenced files, optionally runs each through a selected image style (`buildUrl`) or falls back to the original file URL, and passes an array of image URIs (plus alt/title, and an optional per-image link) to the `icm` theme hook and `templates/icm.html.twig`. Formatter settings let an editor pick an image style, a slider effect (horizontal / vertical / 45deg), and a "link image to" option (nothing / content / file). It attaches the `icm/icm` library and depends on core `image` and the contrib `jquery_ui` module.

Security notes: the module has **no routes, permissions, services, or writable configuration of its own** — it is purely a display formatter configured through Field UI. The one supply-chain caveat is `icm.libraries.yml`: it loads the slider's JavaScript and CSS as *external* assets from a third-party CDN (`cdn.jsdelivr.net/gh/ninjadrupal/icm/...`) with **no version/commit pin**, so every page rendering the formatter fetches whatever currently sits on that GitHub repo's default branch — an availability and integrity risk (a compromised or changed upstream repo would serve arbitrary JS into your pages). The Twig template outputs image URIs and a node canonical path inside `src`/`onclick`; these are Drupal-generated values (Twig-autoescaped), not free user input.
---
No routes/permissions/services/config of its own — a Field UI display formatter only. Depends on `image` and `jquery_ui`. **Supply-chain note:** loads JS/CSS from an unpinned third-party CDN (`cdn.jsdelivr.net/gh/ninjadrupal/icm`), i.e. latest of the repo's default branch — consider vendoring/pinning for production.
---
- Render a two-image field as a draggable before/after comparison slider.
- Show renovation "before vs after" photos on a project page.
- Compare product variants (e.g. retouched vs original) side by side.
- Pick horizontal, vertical, or 45° slider orientation per display.
- Apply an image style to the compared images for consistent sizing.
- Link each compared image to its node (content) or to the file.
- Use it on any content type's or paragraph's image field via Manage display.
- Set the image field to allow 2+ values to feed the comparison.
- Present medical/scientific imagery comparisons (treatment stages).
- Display map or satellite imagery across time periods.
- Show design mockup iterations as an interactive slider.
- Keep alt/title metadata on the compared images for accessibility.
- Fall back to the original image when no image style is selected.
- Add the formatter to a media/entity view display, not only nodes.
- Configure it entirely from the "Manage display" UI (no code).
- Pin/vendor the CDN assets before production use for supply-chain safety.
- Provide a lightweight image-comparison widget without custom JS.
