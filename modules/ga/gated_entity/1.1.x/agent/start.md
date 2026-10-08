<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gated Entity (gated_entity) — agent index

**Locks the rendered view of configured node types behind a pluggable locker; default `login_locker` shows a "Login to unlock" link instead of the body.**

- **Version:** 1.1.x
- **Core:** `^9 || ^10`
- **Config route:** `gated_entity.config` → `/admin/config/content/gated-entities` (perm: `configure gated entities`)
- **Service:** `gated_entity.helper` (`GatedEntityHelper`), plugin manager `plugin.manager.gated_entity_locker`.
- **Plugin type:** `@GatedEntityLocker` (e.g. `LoginLocker`); gating fires via `hook_entity_view_alter` + `GatedEntityCallback::postRender`.

**Security:** enforcement is **presentation-layer only** — `postRender` strips the gated body from the rendered HTML (so it is not leaked in that page), but the module does NOT set node-access grants, so gated nodes remain fully readable via JSON:API/REST/Views/search/edit form and other view modes. The default login locker treats ANY authenticated user as unlocked. Config route is correctly permission-gated. See [configure/gated-entity.md](configure/gated-entity.md) and [plugins/lockers.md](plugins/lockers.md).
