<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Relationship Diagrams (erd) — agent index

Interactive, in-browser diagram of the site's entity types, bundles, fields and the
references between them, built live from the running entity definitions (nothing is stored
in config — the model is read on every page load). A developer/site-builder learning and
inspection tool, not an authoring tool. Core `^9.4 || ^10 || ^11`.

- **Configure what the diagram includes** (output format, field filters) → [configure/settings.md](configure/settings.md)
- **Who can open the diagram** → [permissions/permissions.md](permissions/permissions.md)
- **How the diagram is built, its `drupalSettings` contract, the AJAX save route, and the alter hook** → [api/diagram.md](api/diagram.md)

Key facts:
- **Routes** (all gated by `_permission: 'administer erd'`): `erd.admin` `/admin/structure/erd`
  (the diagram, `EntityRelationshipDiagramController::getMainDiagram`), `erd.settings`
  `/admin/structure/erd/settings` (`EntityRelationshipDiagramSettingsForm`), `erd.ajaxSave`
  `/admin/structure/erd/ajax` (`::saveDiagram`, persists layout to State key `erd.graph`).
- **Permission:** one — `administer erd`. `configure` route = `erd.settings`.
- **Config object** `erd.settings` (created only when the settings form is first saved; no
  `config/install` default, no `config/schema`). Keys: `output_format`, `field_exclude`,
  `property_include`, `entity_reference_only`.
- **No** `.module`/`.install`, no Drush, no plugin types, no config schema.
- **Invokes** `hook_erd_entities_alter(&$entities)` so other modules can add/alter diagram nodes.
- **Module dependencies** (`erd.info.yml`): `jquery_ui:jquery_ui`, `jquery_ui_menu:jquery_ui_menu`,
  `jquery_ui_autocomplete:jquery_ui_autocomplete`, `jquery_ui_resizable:jquery_ui_resizable` —
  contributed backports of jQuery UI components removed from core after Drupal 9.
- **Front-end libraries load from a CDN** (`erd.libraries.yml`: JointJS 1.0.3, Lodash 3.10.1,
  svg-pan-zoom 3.2.6 as `{ type: external }`) — the diagram will not render offline without
  editing `erd.libraries.yml` to serve them locally.
