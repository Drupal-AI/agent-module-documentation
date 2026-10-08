<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Gives visitors control over analytics tracking by preventing selected providers' scripts from loading until the user consents, using browser storage instead of a cookie.

---

On every page, `tracking_options_page_attachments_alter` inspects `#attached[html_head]` for the head snippets registered by supported analytics modules (e.g. Google Analytics, Matomo). For providers configured as "disabling", it removes their inline script from the head and instead wraps the code in a `trackingOptionsLoadScripts()` JS function that only runs when the visitor's stored preference (or default) enables tracking. It respects the browser Do-Not-Track setting, showing an info message instead of the checkbox when DNT is active. A `TrackingOptionsForm` (checkbox) is exposed both as the *Tracking Options block* and as a `[node:tracking-options]` token, and a small JS API (`Drupal.behaviors.trackingOptions.set/toggle`) lets a cookie banner drive the value.

Setup: configure providers, default opt-in/opt-out state and text at `/admin/config/tracking-options/settings` (permission `administer tracking_options settings`, restrict access), then place the block or embed the token (Token Filter needed for token-in-text-format).

---
- Block Google Analytics from loading until the user consents.
- Block Matomo from loading until the user consents.
- Default new visitors to opted-out of tracking.
- Default visitors to opted-in where the law allows.
- Respect the browser Do-Not-Track header automatically.
- Show an informational message instead of the checkbox when DNT is set.
- Place a consent checkbox with the Tracking Options block.
- Embed the consent checkbox via the `[node:tracking-options]` token.
- Store consent in browser storage rather than a cookie.
- Drive consent from a cookie-banner button using the JS API.
- Toggle tracking programmatically with `Drupal.behaviors.trackingOptions.toggle()`.
- Read current state via `Drupal.behaviors.trackingOptions.enabled`.
- Choose which analytics providers are consent-gated.
- Support multiple analytics providers at once.
- Provide an opt-out flow for self-hosted Matomo.
- Restrict configuration to a trusted role (restrict access permission).
