<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AddEvent (addevent) — agent index

**Integrates the AddEvent add-to-calendar service via blocks, a field type and two field formatters.**

- **Version:** 2.0.x (2.0.0-alpha2), core `^10 || ^11`, PHP 8.2, package Other
- **Config route:** `addevent.settings` → `/admin/config/services/addevent/settings` (perm `administer addevent settings`)
- **Permission:** `administer addevent settings`
- **Service:** `addevent.api.factory` (builds authenticated `AddEventCalendarApi`; `Bearer` token from `addevent.settings`)
- **Blocks:** `AddToCalendarBlock`, `SubscribeToCalendarBlock`
- **Field:** type `addevent` (hidden widget) + formatters `AddEventButtonFormatter`, `AddEventLinkFormatter`
- **Security:** admin config route permission-gated; token stored in config and sent as Bearer over HTTPS (default TLS verify on); no anonymous or mutating endpoints.

See [configure/settings.md](configure/settings.md) and [api/factory.md](api/factory.md)
