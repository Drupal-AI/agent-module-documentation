<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Colorbox Load makes ordinary Drupal page links open their target page inside a Colorbox lightbox, loaded over AJAX, instead of navigating away from the current page.

---

The module is a small bridge between the Colorbox library integration (`colorbox`) and NG Lightbox (`ng_lightbox`), and it has no configuration, permissions, plugins or Drush commands of its own. NG Lightbox owns the "which paths should open in a lightbox" list; Colorbox Load contributes an extra **renderer** for it. Concretely it registers one service, `colorbox_load.renderer`, tagged `render.main_content_renderer` with `format: drupal_colorbox` and `ng_lightbox: Colorbox`, which makes "Colorbox" appear in NG Lightbox's *Renderer* select at `/admin/config/media/ng-lightbox`. Its `hook_install()` sets `ng_lightbox.settings:renderer` to `drupal_colorbox` automatically, and `hook_uninstall()` clears it. When a link matches one of the NG Lightbox path patterns, NG Lightbox rewrites it with `class="use-ajax"` and `data-dialog-type="colorbox"` (the renderer id minus the `drupal_` prefix); Drupal then routes the AJAX request to `Drupal\colorbox_load\Renderer`, which renders the page in isolation and returns an `AjaxResponse` carrying a custom `colorboxLoadOpen` command. The module's JS (`js/colorbox_load.js`) implements that command by calling `$.colorbox()` with the rendered HTML at 90% × 90% and re-running `Drupal.attachBehaviors()`. Because the whole thing is a normal link with an AJAX enhancement, bots and "open in new tab" fall back to a normal full page load. For content already present on the page, the project README points you at `colorbox_inline` instead.

---

- Open a node's full page in a Colorbox lightbox when its teaser title is clicked.
- Show a Views page (e.g. `/gallery`) in a lightbox from any link on the site.
- Pop a webform or contact form page open in a lightbox instead of navigating to it.
- Open a Page Manager / Panels page in a Colorbox overlay.
- Give a site that already uses Colorbox for images the same look for page content.
- Replace core's jQuery UI modal styling with Colorbox styling site-wide, by switching the NG Lightbox renderer.
- Load a "terms and conditions" page in a lightbox from a checkout or registration page.
- Preview a product detail page in a lightbox from a listing page.
- Load taxonomy term pages in a lightbox from a tag cloud.
- Lightbox `/user/login` so anonymous visitors can log in without leaving the page.
- Lightbox comment reply forms (`/comment/*/reply`) — NG Lightbox's own example pattern.
- Apply the lightbox to aliased paths as well as internal paths (NG Lightbox checks both).
- Keep lightboxing off admin pages with NG Lightbox's *Skip all admin paths* option.
- Opt a single link into the lightbox by adding the `ng-lightbox` CSS class to it.
- Give the lightbox a custom CSS class so one site section's overlays can be styled differently.
- Set a project-wide default lightbox width for page content.
- Degrade gracefully for search-engine crawlers, which get the plain page.
- Let editors middle-click / "open in new window" a lightboxed link and still get the real page.
- Add a `colorboxLoadOpen` AJAX command you can return from your own controllers to open arbitrary rendered content in Colorbox.
- Reuse Drupal's `renderInIsolation()` rendering so the lightboxed page keeps its attached libraries and settings.
- Migrate a Drupal 7 site that used the D7 "colorbox load" feature to Drupal 10/11.
- Switch between Core Modal, Core Dialog and Colorbox presentation from one settings select without touching code.
- Combine with the Colorbox module's own style/library settings (transition, overlay opacity) since the lightbox is a real Colorbox instance.
- Build a "quick view" experience for a catalogue without writing any AJAX code.
