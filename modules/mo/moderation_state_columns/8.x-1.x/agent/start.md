<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Moderation state columns (moderation_state_columns) — agent index

**Views style that renders moderated entities in one column per Content Moderation workflow state.**

- **Version:** 8.x-1.x
- **Core:** ^8 || ^9 || ^10
- **Dependencies:** content_moderation, views
- **Plugin:** `@ViewsStyle(id="moderation_state_columns")`, theme `views_view_moderation_state_columns`, `usesRowPlugin = TRUE`.
- **Options:** `workflow` (required), `states` (multi-select of that workflow's states).
- **Library:** `moderation_state_columns/view_display` (JS renders the columns from JSON).

**Security:** Pure Views style plugin — no routes/permissions/services/writes. Access is governed by the View's access plugin and per-entity access; rows are pre-resolved by Views. Cache tags from workflow + entities are merged. No security findings.

See [configure/views-style.md](configure/views-style.md)
