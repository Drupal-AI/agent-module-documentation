<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap External Link Pop-up (`bootstrap_external_link_popup`) — agent index

Presentation-only extension of **External Link Pop-up** (`external_link_popup`, a hard
dependency). It replaces that module's jQuery UI leaving-site dialog with a **Bootstrap
modal**. Version **2.2.0**; core `^9.3 || ^10 || ^11`; package Custom; license GPL-2.0-or-later.

## What it actually does (from source)
- **No config, routes, permissions, services, entities, Drush, or config schema of its own.**
  All pop-up content and behavior is configured on the parent module at
  `/admin/config/content/external_link_popup` (*administer external link popup* permission).
- `bootstrap_external_link_popup.module`:
  - `hook_theme()` registers the `bootstrap_external_link_popup` theme hook with five ID
    variables.
  - `hook_page_bottom()` renders one hidden empty Bootstrap `.modal` (Twig template) into the
    bottom of every page, with fixed IDs: `externalLinkPopupModal`, `externalLinkPopupModalLabel`,
    `externalLinkPopupModalBody`, `externalLinkPopupModalCloseButton`,
    `externalLinkPopupModalContinueButton`.
  - `hook_page_attachments_alter()` appends the `bootstrap_external_link_popup/dialog` library
    **only if** `external_link_popup/dialog` is already attached (so it loads on the same pages,
    after the parent).
- `js/dialog.js` overrides `Drupal.behaviors.externalLinkPopup.openDialog`. On an external-link
  click (interception + domain matching are inherited from the parent's behavior) it:
  1. builds the body from `settings.body` with `[link:url]`/`[link:text]` tokens **HTML-encoded**
     (`htmlEncode` = jQuery `$('<div/>').text(value).html()`);
  2. writes `settings.title`, `settings.labelno`, `settings.labelyes`, and the body into the modal
     via jQuery `.html()`;
  3. binds **Continue** to `window.open(element.href, element.target, 'noopener')` then dismisses;
  4. opens the modal via the **Bootstrap 5** API (`new bootstrap.Modal('#externalLinkPopupModal')`)
     when `bootstrap.Tooltip.VERSION` starts with `5`, else the **Bootstrap 4** jQuery `.modal()`.
- `bootstrap_external_link_popup.libraries.yml`: library `dialog` = `js/dialog.js`, depends on
  `external_link_popup/dialog`.

## Requirements / gotchas
- **Ships no Bootstrap CSS/JS.** The active theme (e.g. Radix, Barrio, custom Bootstrap theme)
  must already load Bootstrap's modal component and the global `bootstrap` JS object, or the modal
  never opens.
- Depends on `external_link_popup:external_link_popup`; install/configure that first.
- Theming: override `templates/bootstrap-external-link-popup.html.twig` to add classes — **keep the
  five ID variables** so the JS can target the elements.

## Accessibility / product note
A modal is a focus event: trap focus, allow Escape/keyboard dismissal, return focus to the link.
An interstitial interrupts every outbound click and stops nobody — it earns its place where a
documented leaving-site disclaimer is a genuine requirement; otherwise a visual external-link
indicator is the lighter option.

## Files in this doc set
- `data.json` — metadata.
- `usage.md` — short / dense / use-case summary.
- `agent/config/mechanism.md` — how content flows from parent config into the Bootstrap modal.
