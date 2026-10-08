<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Klaro consent gate — install, config & operation

Install/enable: `composer require drupal/klaro` then `drush en advanced_mautic_integration_klaro`.
Requires the parent `advanced_mautic_integration` module and `klaro`. There is no settings page of its
own — the one option lives on the parent form at **`/admin/config/services/adv-mautic`**.

![Mautic settings form with the Klaro service selector](../../../../../../../../../screenshots/advanced_mautic_integration_klaro/1.1.x/settings-form.png)

## Install / uninstall behaviour (`.install`)

- `hook_install()` sets `advanced_mautic_integration.settings:track.consent_required = TRUE` — enabling
  the submodule *is* the site saying the tracker waits for consent.
- The optional config `config/optional/klaro.klaro_app.mautic.yml` creates a Klaro service `mautic`
  (unless one already exists) with purpose `analytics` and cookie patterns `^mtc_` / `^mautic_`, so
  Klaro can delete those cookies when consent is withdrawn.
- `hook_uninstall()` deliberately leaves the gate on (removing it would silently resume tracking every
  visitor) and shows a warning pointing to the settings page.

## Config object: `advanced_mautic_integration_klaro.settings`

Single key `app_id` (string; schema in `config/schema/*`, install default `mautic`) — the id of the
Klaro service whose consent governs the Mautic tracker. Set it from the **Klaro service that governs
the tracker** select added to the parent form by
`AdvancedMauticIntegrationKlaroHooks::formAdvancedMauticIntegrationAdminSettingsAlter()`; the choice is
saved by `advanced_mautic_integration_klaro_settings_submit()` (a plain function, because form submit
callbacks must survive the cached-form round trip). Point it at a service shared with any other Mautic
integration (e.g. Mautic Audiences) so the visitor sees a single switch. If no `klaro_app` entity
exists, the field becomes a link to add one.

## Runtime wiring

`AdvancedMauticIntegrationKlaroHooks::pageAttachmentsAlter()` runs only when the parent's
`advanced_mautic_integration/tracking_events` library is attached (i.e. on tracked pages): it adds
`drupalSettings.advancedMauticIntegrationKlaro.appId` and the `advanced_mautic_integration_klaro/consent`
library, and registers the config as a cache dependency. In `js/klaro_consent.js`, behavior
`advancedMauticIntegrationKlaro` watches `Drupal.behaviors.klaro.manager`; on each `applyConsents` it
calls `Drupal.advancedMauticIntegration.consent(true)` when `manager.getConsent(appId) === true`, and
`consent(false)` only once the visitor has `confirmed` a choice (an undecided default is never reported,
so the parent keeps the held pageview). See the parent contract at
[../../../../../1.1.x/agent/config/consent.md](../../../../../1.1.x/agent/config/consent.md).

## Diagnosing "the tracker never loads" (`hook_runtime_requirements`)

The gate is silent by design, so `runtimeRequirements()` surfaces the causes on
`/admin/reports/status`:
- **ERROR** — no Klaro service selected, or the selected service does not exist.
- **ERROR** — the selected Klaro service is disabled (Klaro never offers it, so it is never accepted).
- **WARNING** — `track.consent_required` is off (tracker loads for everyone).
- **WARNING** — anonymous role lacks the `use klaro` permission (visitors are never asked).
