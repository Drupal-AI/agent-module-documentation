<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
NG Lightbox opens links whose path matches a configured pattern in a Drupal AJAX dialog instead of a full page load — no JavaScript library of its own, just core's `use-ajax` dialog system driven by a list of paths.

---

Configuration lives in one config object, `ng_lightbox.settings`, edited at `/admin/config/media/ng-lightbox` (route `ng_lightbox.settings`, permission `administer ng lightbox`): `patterns` (newline-separated paths with a leading slash, `*` as wildcard), `default_width` (700), `lightbox_class` (extra CSS class for the dialog), `skip_admin_paths` (TRUE) and `renderer` (`drupal_modal` by default). `hook_link_alter()` runs every rendered link through the `ng_lightbox` service: `isNgLightboxEnabledPath()` rejects external URLs, admin routes when `skip_admin_paths` is on, empty or non-slash paths, then matches the URL against the patterns with the core path matcher — and, if that fails, matches the **path alias** as well, caching each decision per request. Matching links (or any link you hand-mark with the `ng-lightbox` class) go through `addLightbox()`, which appends the core `use-ajax` class, sets `data-dialog-type` to the renderer minus its `drupal_` prefix (`modal` or `dialog`) and encodes `{"width": …, "dialogClass": …}` into `data-dialog-options`. The renderer select is built at compile time: `NgLightboxServiceProvider` tags core's `main_content_renderer.dialog` and `main_content_renderer.modal` services with an `ng_lightbox` label and `NgLightboxPass` collects them into the `ng_lightbox_renderers` container parameter, so any module tagging its own main-content renderer appears in the list too. The module's library (just a dependency on `core/drupal.ajax`) is attached to every page, and `hook_ng_lightbox_ajax_path_alter()` lets code force the lightbox on or off for individual links.

---

- Open a "Terms and conditions" node in a modal instead of navigating away.
- Lightbox all comment reply forms with the pattern `/comment/*/reply`.
- Open the login form (`/user/login`) in a modal from anywhere on the site.
- Show contact forms (`/contact`) in a dialog to keep users on the page.
- Open specific node pages in a modal by aliasing them under `/popup/*`.
- Match by path alias so editors control lightboxing by changing a URL alias.
- Lightbox a single ad-hoc link by adding the `ng-lightbox` class to the anchor.
- Switch the whole site from a modal (overlay) to a non-modal dialog with one setting.
- Set the default dialog width to fit a specific design (e.g. 900px).
- Add a custom CSS class to the dialog so a theme can style it.
- Keep the lightbox off admin pages while it is on for the front end.
- Re-enable the lightbox for a specific admin path with `hook_ng_lightbox_ajax_path_alter()`.
- Turn the lightbox off for one link that would otherwise match the patterns.
- Preview a media or file page in a dialog from a listing.
- Open a Views-generated link (e.g. "read more") in a modal.
- Open a webform in a modal from a call-to-action button.
- Provide a modal "quick view" for products without writing JavaScript.
- Avoid installing Colorbox/Magnific just to open a page in a popup.
- Reuse core's dialog styling and accessibility handling instead of a third-party library.
- Give the dialog per-site branding through `lightbox_class` plus theme CSS.
- Lightbox an entire section with a wildcard pattern such as `/about/*`.
- Migrate a legacy "popup path" list from Drupal 7 straight into the patterns textarea.
- Debug matching with the `ng_lightbox` service's `isNgLightboxEnabledPath()` from drush.
- Combine with `path_alias` so both the internal path and its alias are considered.

