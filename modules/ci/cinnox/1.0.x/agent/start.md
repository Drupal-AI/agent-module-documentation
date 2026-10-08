<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CINNOX (cinnox) — agent index

**Injects the CINNOX omnichannel chat widget script into pages.**

- **Version:** 1.0.x · **Core:** ^8 || ^9 || ^10
- **Config:** `cinnox.settings` → `/admin/config/cinnox/settings` (`administer site configuration`).
- **Hook:** `cinnox_page_attachments_alter()` adds the widget script to non-admin pages when configured.

**Security:** single admin config route, permission-gated; only a third-party script embed, no routes accepting data, no secrets stored beyond the widget ID.
