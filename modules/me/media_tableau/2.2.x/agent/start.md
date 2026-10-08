<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Tableau — agent index

Embeds Tableau visualizations. Ships one **field formatter** (`media_tableau`, for `string`
fields, extends Media Remote's `MediaRemoteFormatterBase`) and one **settings form** for the
allowed-host whitelist. Depends on `media_remote`. Config UI: `media_tableau.allowed_hosts_settings`
at `/admin/config/media/tableau`.

- **Whitelist Tableau hosts / where `allowed_hosts` is stored / CSP frame-src wiring** →
  [configure/allowed-hosts.md](configure/allowed-hosts.md)
- **Use the `media_tableau` formatter (settings keys, URL rewriting, the render template)** →
  [configure/formatter.md](configure/formatter.md)
- **How embedding works internally (regex, library attach, event subscriber)** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Config object `media_tableau.settings` → `allowed_hosts` (sequence; default
  `['https://public.tableau.com']`).
- The `media_tableau` formatter settings live in `core.entity_view_display.<entity>.<bundle>.<mode>`
  → `content.<field>.settings` with keys `api_version` (`latest`|`3.6`|`3.5`), `width`, `height`,
  `toolbar` (bool).
- Permission `administer media_tableau allowed hosts` gates the settings form.
- No Drush, no plugin types, no config entities.
