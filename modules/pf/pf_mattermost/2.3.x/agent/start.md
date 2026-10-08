<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Push Framework Mattermost (pf_mattermost) — agent index

**Mattermost channel for the Push Framework — posts notification content to a channel via the Mattermost API.**

- **Version:** 2.3.x
- **Core:** ^10 || ^11 — requires `push_framework`.
- **Config route:** `mattermost.settings` → `/admin/config/system/push_framework/mattermost` (perm `administer site configuration`).
- **Plugins:** `Mattermost` PushFrameworkChannel + `Mattermost` DanseRecipientSelection.
- **Config:** `pf_mattermost.settings` — `domain`, `token`, `channel_id`. Uses Gnello Mattermost driver over Guzzle.

**Security:** Settings route is permission-gated; Mattermost transport uses the driver's default Guzzle TLS (verification on — no `verify=>false`). See [configure/settings.md](configure/settings.md).
