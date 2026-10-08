<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & mechanism

This module has **no configuration surface of its own** — no settings form, route, permission, or
config schema. Everything a site builder sets lives on the parent **External Link Pop-up**
module.

## Where the settings live (parent module)
- **Global settings:** `/admin/config/content/external_link_popup/settings`
  (`external_link_popup.settings`): `whitelist` (trusted domains, space/comma separated),
  `show_admin` (whether to run on admin pages), default `width`.
- **Pop-ups (config entities):** `/admin/config/content/external_link_popup`
  (`external_link_popup.external_link_popup.*`). Each has: `name`, `id`, `weight`, `status`,
  `close`, `title` (label), `body` (text_format), `labelyes`, `labelno`, `domains`
  (`*` = all, or a domain list), `new_tab`.
- All of the above require the **administer external link popup** permission.

## How the content reaches the Bootstrap modal
1. Parent `external_link_popup_page_attachments()` loads enabled pop-up entities, serializes them
   into `drupalSettings.external_link_popup.popups`, and attaches `external_link_popup/dialog`.
   Each entity's `body` is passed through `check_markup($value, $format)` (the chosen text format)
   before it lands in drupalSettings.
2. This module's `hook_page_attachments_alter()` sees `external_link_popup/dialog` is attached and
   appends `bootstrap_external_link_popup/dialog` after it.
3. This module's `hook_page_bottom()` renders the empty Bootstrap `.modal` markup (Twig template)
   with fixed element IDs.
4. `js/dialog.js` replaces `Drupal.behaviors.externalLinkPopup.openDialog`. The parent behavior
   still intercepts `a` clicks and decides whether a link is external / not whitelisted / matches a
   pop-up's `domains`; when it fires, this override fills the modal:
   - `settings.title` → `#externalLinkPopupModalLabel` via `.html()`
   - `settings.labelno` → `#externalLinkPopupModalCloseButton` via `.html()`
   - `settings.labelyes` → `#externalLinkPopupModalContinueButton` via `.html()`
   - `settings.body` with `[link:url]`/`[link:text]` **HTML-encoded** → `#externalLinkPopupModalBody`
     via `.html()`
   - **Continue** → `window.open(element.href, element.target, 'noopener')`, then triggers the
     close control.
5. Bootstrap version is detected from `bootstrap.Tooltip.VERSION`: `5.x` → `new bootstrap.Modal(...)`;
   otherwise the Bootstrap 4 jQuery `.modal()` path (and `data-dismiss` is rewritten to
   `data-bs-dismiss` for B5).

## Theming
Override `templates/bootstrap-external-link-popup.html.twig` in your theme to add Bootstrap classes
or restructure the modal. **Keep** `modalID`, `modalLabelID`, `modalBodyID`,
`modalCloseButtonID`, `modalContinueButtonID` on their elements — the JS targets them by the IDs
`hook_page_bottom()` supplies.

## Operational checks
- The active theme must load Bootstrap's CSS/JS and expose the global `bootstrap` object; this
  module bundles none of it.
- The pop-up only shows where the parent runs (respects `show_admin` and the domain whitelist).
- `new_tab` / `target` on the link governs whether `window.open` opens a tab or navigates.
