<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Help Scout Beacon (help_scout_beacon) — agent index

**Embeds the Help Scout Beacon support/help widget by attaching its JS keyed to a configured Beacon form id.**

- **Version:** 1.0.x
- **Core:** ^8.8 || ^9 || ^10 || ^11
- **Configure:** `/admin/config/services/help-scout-beacon/settings` — route `help_scout_beacon.settings` (info.yml `configure` mislists it as `help_scout_beacon.setting`).
- **Permissions:** `administer help scout beacon settings` (settings form), `use help scout beacon` (widget is attached only to holders).
- **Config/library:** `help_scout_beacon.settings:help_scout_beacon_form_id`; library `help_scout_beacon/help_scout_beacon_renderer` attached via `hook_page_attachments`.

**Security:** settings route is permission-gated; the Beacon form id is a public client-side embed id (not a secret) exposed via `drupalSettings` only to users with `use help scout beacon`. No credentials stored; no mutating endpoints. No findings.
