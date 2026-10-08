<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node Order — agent index

Lets editors **drag-and-drop the order of nodes within taxonomy terms**. You mark a vocabulary
"orderable", then each term gets an **Order** tab with a tabledrag list; positions are stored as a
`weight` column the module adds to core's `taxonomy_index` table. Depends on `node` + `taxonomy`.

- **Settings, making a vocabulary orderable, the ordering page, Views sort** →
  [configure/settings.md](configure/settings.md)
- **The `nodeorder.manager` service and how positions are stored/maintained** →
  [api/services.md](api/services.md)
- **The two permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Settings config: **`nodeorder.settings`**; admin form `nodeorder.admin` at
  `/admin/config/content/nodeorder`.
- A vocabulary is orderable when its id is a truthy entry in `nodeorder.settings` → `vocabularies`
  (map `vid => vid`).
- Per-term ordering UI: route `nodeorder.admin_order` at `/taxonomy/term/{tid}/order`.
- Node positions live in **`taxonomy_index.weight`** (int column added at install, dropped on
  uninstall) — NOT a config or field.
- Views: a **"Nodeorder"** sort/field is exposed on `taxonomy_index.weight`.
- Permissions: `order nodes within categories`, `administer nodeorder`.
