<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Magnify Image Viewer adds a "Magnify Image Viewer" field formatter for image fields that overlays a magnifying-glass (loupe) hover preview, letting visitors inspect image detail by hovering, with configurable loupe size and zoom scale.

The formatter (`MagnifyFieldFormatter`, extending `ImageFormatterBase`) gathers the field's referenced images, optionally applies a selected image style (`buildUrl`) or uses the original file URL, and passes the image URIs (with alt/title) plus the chosen `size` (90–300 px loupe) and `zoom` (levels 1–5) settings to the `magnify` theme hook and `templates/magnify.html.twig`. It attaches the `magnify/magnify` library and depends on core `image` and the contrib `jquery_ui` module.

Security notes: the module has **no routes, permissions, services, or writable configuration of its own** — configuration is entirely through Field UI. Its `magnify.libraries.yml` loads the zoom JavaScript as an *external* asset from a third-party CDN (`cdn.jsdelivr.net/gh/ninjadrupal/magnifyjs@1.0.0/...`); unlike its sibling `icm`, this URL **is pinned to `@1.0.0`**, which reduces (but does not eliminate) the third-party supply-chain risk of loading code from an external host. The Twig template renders Drupal-generated image URIs (autoescaped); there is no free user-input injection surface.
---
No routes/permissions/services/config of its own — a Field UI display formatter. Depends on `image` and `jquery_ui`. **Supply-chain note:** loads JS from a third-party CDN (`cdn.jsdelivr.net/gh/ninjadrupal/magnifyjs@1.0.0`), pinned to a version — still an external dependency; consider vendoring for production.
---
- Add a hover loupe/zoom to product photos on a catalogue page.
- Let users inspect fine detail (fabric, text, artwork) by hovering.
- Choose a loupe size from 90×90 up to 300×300 pixels.
- Set the zoom scale (level 1–5) per display.
- Apply an image style to the base image while keeping hover zoom.
- Configure the formatter on any content type's image field via Manage display.
- Use it on media or paragraph image fields, not only nodes.
- Show high-detail imagery (maps, blueprints) with on-demand zoom.
- Provide accessible alt/title text alongside the zoomable image.
- Fall back to the original image when no image style is chosen.
- Present artwork or photography portfolios with inspect-on-hover.
- Enable detailed inspection of documents scanned as images.
- Keep the base page lightweight, zooming only on interaction.
- Combine with responsive image styles for the base render.
- Swap the formatter in without writing any custom JavaScript.
- Vendor/pin the CDN asset locally before production for supply-chain safety.
- Give jewellery/watch stores a close-up inspection experience.
