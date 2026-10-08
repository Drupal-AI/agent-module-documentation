<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Consent Mode writes Google's Consent Mode v2 default state — `ad_storage`, `analytics_storage`, `ad_user_data`, `ad_personalization`, `functionality_storage`, `personalization_storage` — onto the page before any Google tag runs.

---

Google Consent Mode expects a `gtag('consent', 'default', {...})` call to execute *before* the analytics or ads tag, declaring what the site assumes about consent until the visitor decides. This module gets that call onto the page early via `hook_page_attachments_alter()` — attaching a small header library (`js/consent_mode.js`) and passing the six signals through `drupalSettings` — and keeps the values in configuration rather than a theme template. Each of the six signals is a checkbox on a single settings form; every one ships denied, the correct default for the EEA and the safe default everywhere. The script also hard-codes `security_storage: 'granted'`, `wait_for_update: 500`, `ads_data_redaction: true` and `url_passthrough: false`.

It is deliberately small: one form, one config object (`consent_mode.consent_mode_config`), one static script, one permission. There is no banner and no consent capture here. This module states the *default* denial; something else — a CMP such as Cookiebot or Usercentrics, or your own banner — has to send the `gtag('consent','update')` call when the visitor chooses. Pairing the two is the normal shape; a site that installs only this one will correctly deny by default and then never grant, which is compliant but will show as near-zero analytics. Turning off the master switch (`consent_mode_enabled`) removes the script entirely.

The settings route `/admin/config/consent_mode` is gated by the module's own `access consent mode config` permission, so consent defaults can be delegated to a marketing role without handing over `administer site configuration`.

---

- Declare Google Consent Mode v2 defaults before any Google tag fires.
- Deny `ad_storage` until the visitor consents.
- Deny `analytics_storage` by default.
- Deny `ad_personalization` and `ad_user_data` by default.
- Control the `functionality_storage` and `personalization_storage` signals.
- Keep consent defaults in exported configuration, not in a template.
- Move a hard-coded `gtag('consent','default')` out of a theme's `html.html.twig`.
- Meet Google's Consent Mode v2 requirement for EEA advertising traffic.
- Pair a consent banner or CMP with the correct default denial state.
- Delegate consent defaults to a marketing role via a dedicated permission.
- Turn the whole default script off with a single checkbox.
- Set permissive (granted) defaults for a non-EEA-only property.
- Audit what a site currently declares to Google by reading one config object.
- Diagnose analytics reporting near zero after a consent rollout.
- Stage consent defaults through configuration deployment across environments.
- Emit `ads_data_redaction` and `url_passthrough` alongside the consent defaults.
- Add Consent Mode support to a stack that already has Google Tag Manager.
- Provide the `default` half that a CMP integration expects to already be present.
- Standardise consent defaults across a multisite via config sync.
- Roll back to all-denied instantly by unchecking the granted signals.
