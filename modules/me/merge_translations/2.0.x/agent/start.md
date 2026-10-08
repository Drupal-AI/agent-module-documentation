<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Merge Translations — agent index

Adds a **Merge translations** tab to nodes so editors can combine separate single-language nodes into
one translated node (rebuilds D7-style translation sets). Depends on core `content_translation`. No
config UI (`configure` null), no config schema, no services/Drush. One form, one permission, one
alter hook.

- **The `merge_permissions admin` permission and node-delete gating** →
  [permissions/permissions.md](permissions/permissions.md)
- **`hook_merge_translations_prepare_alter` — adjust values before they become a translation** →
  [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Route `merge_translations.node` = `/node/{node}/merge_translations`, form `MergeTranslationsForm`,
  requires permission `merge_permissions admin` (`restrict access: true`).
- Target = the routed node; each language row picks a same-bundle source node (entity autocomplete);
  submit copies source field values into the target via `addTranslation()` (won't overwrite existing).
- Optional "Remove node" after import only shows / runs with node delete access (`bypass node access`
  / `delete any|own <type> content`) plus a final `access('delete')` check.
- Node-only (`ENTITYTYPE = 'node'`).
