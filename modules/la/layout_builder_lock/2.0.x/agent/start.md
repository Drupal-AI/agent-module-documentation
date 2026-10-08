<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder Lock (layout_builder_lock) — agent index

**Locks Layout Builder sections** so editors on overrides can't add/move/remove blocks or add sections around them. Version **2.0.0-rc2**. Core `^9.2..^11`. Requires core **layout_builder**.

Per-section lockable operations: add block, move/update block, delete block, add section before/after.

Permissions:
- `manage lock settings on default display` — set locks on the default layout.
- `manage lock settings on overrides` — set locks on overrides.
- `bypass lock settings on layout overrides` — ignore locks when editing overrides.
- `remove sections with lock settings`.

Security note: enforcement is UI/access-model guard-railing for editors who already have Layout Builder access — governance, not a hard boundary. See [configure/lock-settings.md](configure/lock-settings.md).