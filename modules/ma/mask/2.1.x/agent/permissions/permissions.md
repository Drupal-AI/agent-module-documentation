<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `mask.permissions.yml`:

| Machine name | Title | `restrict access` | Gates |
|---|---|---|---|
| `administer mask module` | Administer Mask Field module | true | The settings form `mask.settings` at `admin/config/content/mask` (CDN/local library choice and the translation-symbol table). |

Marked `restrict access: true` because editing the pattern table and the library source is a
site-configuration task. It does **not** gate per-field mask settings — those are edited on
*Manage form display*, gated by the usual `administer <entity> form display` permissions.
