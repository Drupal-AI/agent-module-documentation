# Entity Mesh — agent index

Analyzes links inside content: renders each entity, extracts every href/iframe/image, resolves targets, and
stores source→target relationships in the `entity_mesh` table for reporting and a D3 graph. Sources are
registered with **entity_registry**; rendering uses **entity_render_context**. Admin report at
`/admin/reports/entity-mesh`; config at `/admin/config/system/entity-mesh` (`configure` =
`entity_mesh.settings_form`). Both admin surfaces gated by `restrict access: true` perms. No Drush.

- **Settings form + cron form: every config key, analyzer account, processing modes, source/target gating** → [configure/settings.md](configure/settings.md)
- **Architecture: analysis pipeline, entity_registry consumers, menu mesh, Views + D3 style, data table** → [api/architecture.md](api/architecture.md)
- **The two permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config object `entity_mesh.settings` (schema `entity_mesh.schema.yml`): `source_types`, `target_types`
  (`internal`/`external` schemes+categories), `menu_types`, `analyzer_account`, `processing_mode`
  (`synchronous`/`asynchronous`), `synchronous_limit`, `cron_enabled`, `cron_limit`, `self_domain_internal`,
  `check_unmanaged_files`, `track_no_links`, `debug`.
- Registers 2 entity_registry consumers: `entity_mesh` (link mesh) and `entity_mesh_menu` (menu edges).
- Views plugins: style `entity_mesh_d3_style` (D3 force graph) + many field/filter plugins; ships Views
  `entity_mesh`, `entity_mesh_node`, `entity_mesh_media`, `entity_mesh_taxonomy`, `entity_mesh_domains`.
- Data stored in the `entity_mesh` DB table (schema in `entity_mesh.install`); no config/content entities defined.
- Defines no plugin types of its own (implements plugins from core Views + entity_registry).
- The `d3` asset library loads from the external `https://d3js.org` CDN.
