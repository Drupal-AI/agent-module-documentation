<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mautic Audiences: Klaro consent gate (mautic_audiences_klaro) — agent index

Submodule of **mautic_audiences**. Wires the Klaro consent manager into the resolver's consent gate: when the visitor has not granted consent for the configured Klaro app, `mautic_audiences.resolver` returns an empty audience. Version **1.1.x**, core `^10.3 || ^11`.

- **Depends on** `mautic_audiences` and `klaro`.
- **Provides:** the `mautic_audiences_klaro.consent_check` service (an `__invoke()` / `isAllowed()` consent callback) and a settings form for choosing the Klaro app id.
- **Route:** `/admin/config/services/mautic-audiences/klaro` (`mautic_audiences_klaro.settings_form`, perm `administer mautic audiences`).
- **Config:** `mautic_audiences_klaro.settings:app_id` (default `mautic`).
- Parent project docs: `../../../../1.1.x/agent/start.md`; the resolver's consent gate is in `../../../../1.1.x/agent/api/resolver.md`.

## Solution docs
- [config/settings.md](config/settings.md) — the `KlaroConsentCheck` service, the settings form, and wiring `consent_callback`.
