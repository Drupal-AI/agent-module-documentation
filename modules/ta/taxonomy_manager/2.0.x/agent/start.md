# taxonomy_manager — agent start

Tree-based admin UI for core Taxonomy: mass add / delete / move / edit terms of a
vocabulary from one AJAX (Fancytree) page. Depends on core `taxonomy` + `jquery_ui`
(Fancytree library suggested). Tree UI: **Admin → Structure → Taxonomy Manager**
(`/admin/structure/taxonomy_manager/voc/{vocabulary}`, route `taxonomy_manager.admin`).
Settings UI: `/admin/config/user-interface/taxonomy-manager-settings`
(route `taxonomy_manager.settings`, the `configure` route).

- The tree admin UI, routes, toolbar operations & settings → [configure/configure.md](configure/configure.md)
- Permissions (module + which core taxonomy perms gate operations) → [permissions/permissions.md](permissions/permissions.md)
- Bulk term services & the reference-selection plugin → [api/api.md](api/api.md)
- Submodule: merge duplicate terms → [../../modules/taxonomy_manager_merge/2.0.x/agent/start.md](../../modules/taxonomy_manager_merge/2.0.x/agent/start.md)
