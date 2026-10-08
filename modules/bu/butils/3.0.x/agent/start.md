<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Backend Utils (butils) — agent index
**One autowired service of ~30 helper traits + a Twig extension for backend developers.**

- **Version:** 3.0.x  •  **Core:** ^10.1 || ^11
- **Service:** `butils` (alias `Drupal\butils\BUtils`), autowired, many core deps
- **Extras:** `butils.twig_extension` (Twig), `butils_debug_log` (event subscriber), `json_metadata` field type/widget/formatter
- **Hooks:** `node_insert`/`node_update` → invoke-all `node_save`; `butils_page_entity()` current entity
- **Security:** no routes/permissions/UI; a code-level utility library. No request surface, no security findings.

See [api/traits.md](api/traits.md).