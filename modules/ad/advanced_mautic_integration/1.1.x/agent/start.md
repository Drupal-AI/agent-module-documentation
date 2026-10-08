<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Mautic Integration (advanced_mautic_integration) — agent index

Integrates Drupal with **Mautic** (open-source marketing automation). Two halves: (1) publishes the
Mautic `mtc.js` tracking config to `drupalSettings` and attaches a client library that loads the
tracker + does link/download tracking on Condition-API-selected pages, with an optional consent gate;
(2) wraps the Mautic REST API (`mautic/api-library`, Basic Auth) and syncs Drupal users → Mautic
contacts on user insert/update. Package `Statistics`. Depends on **`token`**. Core `^10 || ^11`.
Installed 1.1.1. Ships a config schema + install default. Bundles the **`advanced_mautic_integration_klaro`**
submodule (Klaro consent). License GPL-2.0-or-later.

## Solution docs
- **Settings form, config object keys, tracking snippet & visibility** → [config/settings.md](config/settings.md)
- **Consent gate (`track.consent_required`) + JS consent contract** → [config/consent.md](config/consent.md)
- **API wrapper service + user→contact synchronizer (custom API usage)** → [api/api.md](api/api.md)
- **Klaro submodule** → [../../modules/advanced_mautic_integration_klaro/1.1.x/agent/start.md](../../modules/advanced_mautic_integration_klaro/1.1.x/agent/start.md)

## What it actually provides (from source)
- **1 route / 1 permission**: `advanced_mautic_integration.admin_settings_form` at
  `/admin/config/services/adv-mautic`, `_permission: 'administer advanced mautic integration'`
  (`*.routing.yml`, `*.permissions.yml`), menu link under *Configuration → Services*
  (`*.links.menu.yml`). Config route id is the `configure` value.
- **4 services** (`*.services.yml`):
  - `advanced_mautic_integration.visibility` → `VisibilityTracker` — decides whether the snippet is
    shown, by resolving stored Condition plugins (`plugin.manager.condition`).
  - `advanced_mautic_integration.script` → `MauticScript` — builds the `drupalSettings` tracking
    config (`getTrackingSettings()`); tokens replaced via `Token::replacePlain()`.
  - `advanced_mautic_integration.api` → `MauticApiWrapper` (implements `MauticApiWrapperInterface`) —
    `getApi($context)` returns a `\Mautic\Api\Api` bound to the configured URL + Basic Auth.
  - `advanced_mautic_integration.user_synchronizer` → `UserSynchronizer`
    (implements `UserSynchronizerInterface`) — `push()`, `getLeadIdForUser()`, `convertUserToLead()`,
    `getLeadByParameter()`.
- **1 hook-implementation service**: `Hook\AdvancedMauticIntegrationHooks` (OOP `#[Hook]` methods;
  the `.module` file only forwards for Drupal 10 via `#[LegacyHook]`).
- **1 config object**: `advanced_mautic_integration.settings` (`track.*`, `api.*`, `visibility`),
  with `config/schema/*` and `config/install/*` shipped.
- **1 form**: `Form\MauticAdminSettingsForm` (extends `ConfigFormBase`).
- **1 library**: `advanced_mautic_integration/tracking_events` (`js/tracking_events.js`, deps
  `core/drupal`, `core/drupalSettings`, `core/once`) exposing `Drupal.mt_send()`,
  `Drupal.advancedMauticIntegration.consent()/hasConsent()`, and behavior
  `advancedMauticIntegrationTrackingEvents`.
- **Hooks**: `hook_help`, `hook_page_attachments` (publishes settings + library when
  `VisibilityTracker::isVisible()` is true), `hook_user_insert`/`hook_user_update` (call the
  synchronizer when `api.synchronize_user` is on; errors caught + logged to the
  `advanced_mautic_integration` channel).
- **No** entities, no Drush, no new plugin types (it *consumes* core Condition plugins).
