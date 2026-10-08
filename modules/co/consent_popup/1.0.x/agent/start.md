<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Consent Popup (consent_popup) — agent index

One Block plugin that renders a full-screen consent / age-gate popup with **Accept** and
**Decline** buttons, remembering the choice in a browser cookie. Everything (all wording, cookie,
colours, blur) is configured **in the block instance** — there is no settings page, no routes, no
permissions, and no config schema. No dependencies beyond Drupal core.

> **This is a notice/gate, not a consent manager.** It shows a banner and (optionally) blocks the
> page on decline, but it does **not** withhold or defer third-party tracking scripts. On a site
> that runs analytics/marketing tags it does not by itself satisfy GDPR/ePrivacy consent — use a
> manager (Klaro / Orejime family) there. It fits: sites with no third-party tracking, age gates,
> terms/policy acknowledgements, one-off announcements.

Core: `^8.8 || ^9 || ^10 | ^11` (note the single `|` before `^11` — an upstream typo; it still
parses). Installed/enabled as **1.0.6**; version dir `1.0.x`. Package `Custom`.

## What you'd do → where

- **Place the block and set its wording, cookie, decline/redirect behaviour, colours and blur** →
  [configure/consent_popup.md](configure/consent_popup.md)
- **Override the Twig template / CSS, or read the `drupalSettings` the JS consumes** →
  [theming/consent_popup.md](theming/consent_popup.md)

## Key facts (real machine names)

- Block plugin id: **`consent_popup`** (`admin_label` "Consent Popup", category "Custom"),
  class `Drupal\consent_popup\Plugin\Block\ConsentPopupBlock`. Configured via the block placement /
  block-config form — gated by core's **`administer blocks`** permission.
- Theme hook: **`consent_popup`** (variable `items`), template
  `templates/consent-popup.html.twig` (markup id `#javali-popup`).
- Library: **`consent_popup/consent_popup`** (`js/consent-popup.js`, `css/consent-popup.css`);
  deps `core/drupal`, `core/drupalSettings`, `core/once`, `core/jquery`.
- Config keys (block config, per-language under each `langcode`): `text`, `text_decline`,
  `accept`, `decline`, `decline_link.decline_url`, `decline_link.decline_url_text`; site-wide:
  `non_blocking`, `redirect`, `cookie.cookie_name` (default `consent_popup`),
  `cookie.cookie_life` (days, default 7), `design.color` (hex, default `#000000`),
  `design.color_opacity` (0–1 in tenths), `design.blur` (comma-separated CSS selectors).
- Client behaviour (`Drupal.behaviors.consent_popup`): if the cookie ≠ `true`, opens the overlay
  (`body.consent-popup-opened`, `overflow:hidden`); **Accept** sets `cookie=true` and closes;
  **Decline** sets `cookie=false` (or `true` when `non_blocking`), then either
  `window.location.replace(redirect_url)` (when `redirect`) or swaps in the declined text + link
  and leaves the overlay up.
- No `{name}.permissions.yml`, no `{name}.routing.yml`, no `config/` (no shipped defaults or
  schema), no Drush, no submodules. `hook_help` renders README on the module's help page.
