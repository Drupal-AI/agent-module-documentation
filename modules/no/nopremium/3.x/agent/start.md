<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node Option Premium (nopremium) — agent index

Shows only the **teaser** of premium-flagged nodes to unprivileged users (per-type permission for
full view). Version **dev**. Core `^9.1 || ^10 || ^11`.

**DISPLAY-ONLY — NOT access control.** Implemented via `hook_entity_view_mode_alter()` + a Search
API processor; **no node/entity/field-access hook**, so node view access is never restricted.

**Honest use:** a soft marketing gate for non-secret content. **Never** for confidential/paid
content — use real field/node access and filter JSON:API/REST.