<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bootstrap External Link Pop-up swaps the `external_link_popup` module's jQuery UI "you are leaving this site" dialog for a Bootstrap modal, so the outbound-link confirmation matches a Bootstrap-themed frontend without extra CSS.

---

This module is a thin presentation layer over **External Link Pop-up** (`external_link_popup`), which it hard-depends on. The parent module owns everything configurable — the pop-up messages, titles, Yes/No button labels, the trusted-domain whitelist and which links trigger a warning — all managed at `/admin/config/content/external_link_popup` under the *administer external link popup* permission; this module adds **no routes, permissions, config or config schema of its own**. What it contributes is exactly two things. First, `hook_page_bottom()` renders a Twig template (`templates/bootstrap-external-link-popup.html.twig`) that places one empty, hidden Bootstrap `.modal` markup block near the end of every page, with fixed element IDs (`externalLinkPopupModal`, `…ModalLabel`, `…ModalBody`, `…ModalCloseButton`, `…ModalContinueButton`). Second, `hook_page_attachments_alter()` appends the module's `dialog` library **only when** the parent's `external_link_popup/dialog` library is already attached, and that JS (`js/dialog.js`) overrides `Drupal.behaviors.externalLinkPopup.openDialog`: on an external-link click it copies the popup's title, body (with `[link:url]`/`[link:text]` tokens HTML-encoded), and button labels into the modal, wires the **Continue** button to `window.open(element.href, element.target, 'noopener')`, then opens the modal using the Bootstrap 5 API (`new bootstrap.Modal(...)`) or the Bootstrap 4 jQuery `.modal()` API depending on the detected `bootstrap.Tooltip.VERSION`. Because it reuses the parent's click-interception and domain matching, everything about *when* a warning appears is inherited unchanged. Crucially, **the module ships no Bootstrap CSS or JS** — the active theme (Radix, Barrio, or a custom Bootstrap theme) must already load them, or the modal silently fails to open. Version **2.2.0**, core `^9.3 || ^10 || ^11`. Theming is done by overriding the provided Twig template (keep the ID variables intact) to add Bootstrap classes. As with any modal, treat it as a focus event: it should trap focus, be dismissable with Escape/keyboard, and return focus to the link — and remember an interstitial interrupts every outbound click and stops no one, so it earns its place mainly where a documented leaving-site disclaimer is a real requirement.

---

- Show the external-link "you are leaving this site" warning as a Bootstrap modal.
- Match the outbound-link confirmation to a Bootstrap-themed frontend.
- Avoid writing custom CSS to restyle the parent module's jQuery UI dialog.
- Reuse the theme's already-loaded Bootstrap modal component for the interstitial.
- Present a regulatory leaving-site disclaimer in on-brand styling.
- Warn visitors before they follow a link to a third-party domain.
- Keep a public body from appearing to endorse external content.
- Add a compliance interstitial on a financial or health site using Bootstrap.
- Confirm before opening partner or affiliate links in a new tab.
- Support both Bootstrap 4 and Bootstrap 5 themes with one module.
- Override the parent module's `openDialog` to render into a Bootstrap `.modal`.
- Place a reusable hidden modal in the page bottom via a Twig template.
- Customize the modal markup by overriding `bootstrap-external-link-popup.html.twig`.
- Add extra Bootstrap classes to the leaving-site modal without patching the parent.
- Keep outbound-link configuration centralized in External Link Pop-up.
- Trigger the modal only on links outside the configured domain whitelist.
- Open the confirmed destination safely with `noopener` to prevent reverse tabnabbing.
- Provide a documented, styled exit disclaimer for an accessibility/compliance audit.
- Show a themed confirmation when leaving a secure or members-only area.
- Standardize interstitial styling across a Bootstrap-based multisite.
