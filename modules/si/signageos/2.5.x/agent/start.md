<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# signageOS (signageos) — agent index

**Connector that integrates Drupal's Digital Signage Framework with the signageOS platform.**

- **Version:** 2.5.x
- **Core:** ^10 || ^11 — requires `digital_signage_framework`.
- **Config route:** `signageos.settings` → `/admin/config/services/digital_signage_framework/signageos` (perm `administer site configuration`).
- **Power action:** `signageos.poweraction` → `/admin/content/digital-signage-device/sos-power-action` (perm `execute signageos power action`).
- **Service:** `signageos.event_subscriber` (`EventSubscriber\SignageOs`) — reacts to framework events.

**Security:** Both routes are permission-gated (site config / dedicated power-action permission); no anonymous or public endpoints. No security findings. See [configure/settings.md](configure/settings.md).
