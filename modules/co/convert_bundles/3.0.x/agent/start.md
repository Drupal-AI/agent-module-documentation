<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Convert Bundles — agent index

Converts existing entities from one bundle to another, mapping the source bundle's fields
onto the target bundle's fields. Works on any entity type with 2+ bundles (node, taxonomy
term, media, paragraph, block_content, …). Exposed as core **actions**, so it also works from
`/admin/content` bulk ops and VBO/Rules.

Key facts:
- `configure` route = `convert_bundles.admin` → `/admin/config/content/convert_bundles` (convert a whole bundle). Also `/admin/convert_bundles` (`convert_bundles.form`, the wizard target).
- On install it auto-creates one action per multi-bundle entity type: config id `system.action.convert_bundles_on_<entity_type>`, plugin `convert_bundles_action_base`.
- No config schema, no Drush, no plugin types the module defines. Its only owned config is the action entities.

- **Run a conversion (3 entry points: per-entity tab, bulk action, whole-bundle form) + the actions** →
  [configure/convert.md](configure/convert.md)
- **Permissions (`administer convert_bundles` + dynamic `convert <entity_type> bundle`)** →
  [permissions/permissions.md](permissions/permissions.md)
- **How conversion works internally (`ConvertBundles` helper, table rewrite, field mapping, batch)** →
  [api/mechanism.md](api/mechanism.md)
- **Alter a converted entity before it is saved** → [hooks/alter.md](hooks/alter.md)
