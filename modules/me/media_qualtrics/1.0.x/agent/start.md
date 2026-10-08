<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Qualtrics — agent index

Renders a Qualtrics survey/form URL stored in a **`string` field** as an auto-resizing
`<iframe>`, via a Media Remote field formatter. Depends on **`media_remote`**. Only URLs
matching the configured **allowed hosts** are rendered.

- **Configure allowed Qualtrics hosts (the only settings form) + where it is stored** →
  [configure/allowed-hosts.md](configure/allowed-hosts.md)
- **The `media_qualtrics` field formatter: how to apply it, what it matches, how it renders** →
  [plugins/formatter.md](plugins/formatter.md)
- **CSP `frame-src` integration + the JS iframe resizer (mechanism)** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Config object `media_qualtrics.settings` → `allowed_hosts` (sequence of `https://` domains,
  default `['https://qualtrics.com']`).
- Configure route `media_qualtrics.allowed_hosts_settings` → `/admin/config/media/qualtrics`,
  permission **`administer qualtrics allowed hosts`**.
- Formatter plugin id **`media_qualtrics`** (label "Remote Media - Qualtrics"), `field_types = {string}`.
- No Drush, no plugin types defined, no custom entities.
