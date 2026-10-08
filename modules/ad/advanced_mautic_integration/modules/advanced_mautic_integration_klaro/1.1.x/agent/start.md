<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Mautic Integration: Klaro consent (advanced_mautic_integration_klaro) — agent index

Submodule of **advanced_mautic_integration**. Holds the Mautic tracker back until the visitor consents
in the **Klaro** consent manager, then reports the decision to the parent module's JS consent contract.
Depends on `advanced_mautic_integration` and `klaro`. Package `Statistics`. Core `^10.2 || ^11`.
Installed 1.1.1. Ships a config object + schema and an optional Klaro service config. No routes,
permissions, or entities of its own. License GPL-2.0-or-later.

## Why it exists
Klaro blocks a script by rewriting its `<script src>` at build time, but the Mautic tracker is created
in the browser after load — there is nothing in the markup to rewrite. So the decision is pushed to the
loader via `Drupal.advancedMauticIntegration.consent()` instead (parent's contract, see
[../../../../1.1.x/agent/config/consent.md](../../../../1.1.x/agent/config/consent.md)).

## Solution docs
- **Install behaviour, config object, service selector, status checks** → [config/settings.md](config/settings.md)

## What it actually provides (from source)
- **1 hook-implementation service**: `Hook\AdvancedMauticIntegrationKlaroHooks` (`*.services.yml`;
  deps `config.factory`, `entity_type.manager`). OOP `#[Hook]` methods; `.module`/`.install` forward
  for Drupal 10 via `#[LegacyHook]` / `#[LegacyRequirementsHook]`.
  - `#[Hook('page_attachments_alter')]` — when the parent's `advanced_mautic_integration/tracking_events`
    library is attached, adds `drupalSettings.advancedMauticIntegrationKlaro.appId` (config `app_id`,
    default `mautic`) and the `advanced_mautic_integration_klaro/consent` library.
  - `#[Hook('form_advanced_mautic_integration_admin_settings_alter')]` — adds a `klaro_app_id` select
    (populated from `klaro_app` entities) next to the consent checkbox; a plain submit callback
    `advanced_mautic_integration_klaro_settings_submit()` saves the choice.
  - `#[Hook('runtime_requirements')]` — status-report checks (no/disabled service, gate off, anon
    missing *Use Klaro UI*).
  - `#[Hook('help')]`.
- **1 install hook**: `hook_install` sets `advanced_mautic_integration.settings:track.consent_required = TRUE`;
  `hook_uninstall` leaves the gate on and warns.
- **1 config object**: `advanced_mautic_integration_klaro.settings` (`app_id`), with `config/schema/*`
  and `config/install/*` (`app_id: mautic`).
- **1 optional config**: `config/optional/klaro.klaro_app.mautic.yml` — a Klaro service `mautic`
  (purpose `analytics`; cookies `^mtc_`, `^mautic_`; javascripts `mtc.js`).
- **1 library**: `advanced_mautic_integration_klaro/consent` (`js/klaro_consent.js`, deps `core/drupal`,
  `core/drupalSettings`, `core/once`, `klaro/klaro`, `advanced_mautic_integration/tracking_events`) —
  behavior `advancedMauticIntegrationKlaro` watches the Klaro manager and calls `consent()`.

## Related
- Parent module index → [../../../../1.1.x/agent/start.md](../../../../1.1.x/agent/start.md)
