<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Content Groups (ckeditor_content_groups) — agent index

**Adds accordion and horizontal/vertical tab content groups to CKEditor 5.**

- **Version:** 1.0.x (1.0.1)
- **Core:** ^10 || ^11 · **Depends on:** ckeditor5
- **Plugins:** `Plugin/CKEditor5Plugin/Accordion`, `TabsHorizontal`, `TabsVertical` (shared `ContentGroupsBase`); editor CSS via `ckeditor5-stylesheets`
- **Submodule:** `ckeditor_content_groups_schema` (schema-aware widget variants)
- **Routes/permissions/services:** none of its own
- **Security:** no server routes; behavior is client-side CKEditor 5 plugins. Allowed markup is bounded by each text format's own filters (site builders control which formats/toolbars enable it).

See [plugins/widgets.md](plugins/widgets.md)
