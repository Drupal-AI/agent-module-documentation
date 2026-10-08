<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mautic Audiences (mautic_audiences) — agent index

Turns a visitor's Mautic **segments** and **tags** into a Drupal audience primitive. A single resolver service (`mautic_audiences.resolver`) reads local stores on the render path (`user.data` for authenticated users, `keyvalue.expirable` keyed by the `mtc_id` cookie for anonymous); the Mautic API is touched only on webhook / cron / Drush. Version **1.1.x**, core `^10.3 || ^11`, PHP `^8.2`.

- **Depends on** `advanced_mautic_integration` (provides `@advanced_mautic_integration.api`, the Mautic API wrapper, and the tracking script). No external Composer libraries.
- **Provides:** identity-strategy plugin type, two block/LB Condition plugins, two Views filters, a queue worker, three cache contexts, a Twig extension, tokens, a JS library, Drush commands, an inbound webhook + two visitor endpoints, an editorial report.
- **Submodules** (documented separately): `mautic_audiences_field` (audience field + view-access gate) at `../../modules/mautic_audiences_field/1.1.x/`, `mautic_audiences_klaro` (Klaro consent gate) at `../../modules/mautic_audiences_klaro/1.1.x/`.

## Routes
- `/admin/config/services/mautic-audiences` — settings form (`mautic_audiences.settings_form`, perm `administer mautic audiences`).
- `/mautic-audiences/webhook` — inbound Mautic webhook (POST, `_access: TRUE`).
- `/mautic-audiences/me` — per-visitor audience metadata (GET, `_access: TRUE`).
- `/mautic-audiences/check` — boolean membership check for caller-supplied names (POST, `_access: TRUE`).
- `/admin/reports/mautic-audiences` — editorial debug report (`mautic_audiences.debug`, perm `administer mautic audiences`).

## Solution docs
- [config/settings.md](config/settings.md) — settings form, config keys + schema, permissions, install/enable, Drush config.
- [api/resolver.md](api/resolver.md) — the audience model: resolver + `AudiencesValue`, identity-strategy plugin type, refresh/reconcile, queue worker, Drush commands, hooks.
- [endpoints/http-endpoints.md](endpoints/http-endpoints.md) — the webhook, `/me`, `/check`, access model, and the `Drupal.mauticAudiences` JS API.
- [plugins/visibility.md](plugins/visibility.md) — block/LB conditions, the global Views filter, Twig functions, tokens, and cache contexts.
- [reports/debug.md](reports/debug.md) — the `/admin/reports/mautic-audiences` diagnostics page, operational metrics, and preview-as-audience.
