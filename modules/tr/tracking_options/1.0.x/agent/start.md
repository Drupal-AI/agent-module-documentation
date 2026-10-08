<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tracking Options (tracking_options) — agent index

**Consent gate for analytics providers: strips their head scripts and only loads them when the visitor opts in; respects Do-Not-Track.**

- **Version:** 1.0.x (dev-1.0.x checkout)
- **Core:** ^9 || ^10 | ^11
- **Configure route:** `tracking_options.settings_form` → `/admin/config/tracking-options/settings` (`_permission: administer tracking_options settings`, restrict access)
- **Permission:** `administer tracking_options settings` (restrict access)
- **Service:** `tracking_options.manager` (ProvidersManager) — `getDisablingProviders()`, `getDefaultTrackingConfig()`
- **Hook:** `tracking_options_page_attachments_alter` moves provider scripts into a gated `trackingOptionsLoadScripts()` function
- **Surface:** `TrackingOptionsBlock` block + `[node:tracking-options]` token (needs Token Filter in text formats); JS API `Drupal.behaviors.trackingOptions.*`
- **Libraries:** `tracking-options-js`, `tracking-options-base`

**Security:** single admin settings route, permission-gated (restrict access). Reshuffles already-configured analytics snippets (admin-provided) into a consent-gated loader; the injected code originates from site config, not user input. No anonymous or mutating endpoints.
