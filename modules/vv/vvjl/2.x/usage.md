<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VVJL adds an accessible, vanilla-JavaScript lightbox Views style that renders view rows as a clickable image grid, opening each row in a modal with prev/next navigation.

---

Views Vanilla JavaScript Lightbox (VVJL) is a Views display format (style plugin `views_vvjl`, class `Drupal\vvjl\Plugin\views\style\Lightbox`) for Drupal 11.3+/12. Set a view's Format to "Views Vanilla JavaScript Lightbox" with Show set to Fields; the first field must be an image. The style renders rows as a CSS-grid gallery inside a `<vvjl-lightbox>` custom element (extending vvj_core's `VvjElementBase`); clicking a tile opens a `role="dialog"` modal with previous/next navigation, six animation presets, a configurable overlay color/opacity, native focus trap (from `vvj_core/focus-trap`), Escape-to-close, ARIA state, screen-reader announcements, and lazy IntersectionObserver hydration. v2 is a drop-in upgrade of 1.x that moves shared behavior onto the `drupal/vvj_core` foundation while preserving the plugin ID, theme hooks, template names, option keys, library names, JS behavior key, and CSS classes. It also exposes `[vvjl:FIELD]` / `[vvjl:FIELD:plain]` Views tokens (resolved by `vvj_core.token_resolver`) for reading the first row's field values in header/footer/empty text, and renders README.md at `/admin/help/vvjl`.

---

- Turn a view of image content into a clickable lightbox gallery.
- Add an accessible (WCAG-minded) image lightbox to any Drupal site without jQuery.
- Display a photo gallery grid where each thumbnail opens a full-size modal.
- Provide keyboard-navigable image browsing with prev/next controls and Escape-to-close.
- Build a portfolio or product-shot gallery driven by a Views query.
- Configure per-image grid width and gap to control gallery layout.
- Apply a colored, opacity-controlled overlay behind caption/foreground text.
- Choose an image-transition animation (none, zoom, slide from top/right/bottom/left).
- Disable the overlay entirely for a plain image grid.
- Add captions or overlay text by placing extra Views fields after the image field.
- Show the first view row's field values in a Views header/footer using `[vvjl:title]` style tokens.
- Output plain-text token values (HTML stripped) with the `:plain` suffix, e.g. `[vvjl:title:plain]`.
- Upgrade an existing 1.x lightbox view to v2 with `composer update` + `drush cr` (no reconfiguration).
- Ship an accessible lightbox that respects users' reduced-motion preference.
- Provide a screen-reader-announced, ARIA-correct modal image viewer.
- Keep modal focus trapped for accessible keyboard operation.
- Present a responsive gallery that adapts across screen sizes.
- Import the bundled `vvjl_example` optional view as a working reference configuration.
- Read the module's usage help in-admin at `/admin/help/vvjl` (Markdown-rendered when the markdown filter is enabled).
- Theme the gallery via preserved CSS classes (`.vvjl`, `.vvjl-inner`, `.lightbox-row`, `.lightbox-modal`).
- Pair with core Image styles to serve appropriately sized grid thumbnails.
- Use as one component of the broader VVJ vanilla-JavaScript Views suite alongside the shared vvj_core foundation.
