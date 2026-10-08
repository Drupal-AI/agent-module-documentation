<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Toggle Logger Channels (toggle_channels) — agent index

**Replaces the `logger.factory` service so individual log channels can be toggled off (routed to a no-op logger) via a settings form.**

- **Version:** 2.0.x
- **Core:** ^10.3 || ^11
- **Configure:** `/admin/config/development/logging/toggle_channels` — permission `administer site configuration`.
- **Mechanism:** `ToggleChannelsServiceProvider::alter()` sets `logger.factory` class to `NullableLoggerChannel`; `logger.toggle_channels` (`NullableLogger`, all PSR-3 methods empty) is the drop sink. Config `toggle_channels.settings` holds which channels are disabled.
- **Routes/permissions:** one admin route; no permission of its own (uses core `administer site configuration`).

**Security:** Admin-only settings route gated by `administer site configuration`; no anonymous or mutating public endpoints. Caveat (operational, not a vuln): disabling channels drops their log entries globally — do not silence security/audit channels or you lose that trail. No dangerous input handling.