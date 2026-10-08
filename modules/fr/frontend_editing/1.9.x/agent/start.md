<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Frontend Editing — agent index

Edit content on the rendered page: entity forms open in a slide-in sidebar, and Paragraphs
get inline add/move/delete/duplicate controls. Hard dependency on **`paragraphs_edit`**.
Config UI: `/admin/config/frontend-editing` (route `frontend_editing.settings_form`). All
settings live in the **`frontend_editing.settings`** config object.

- **Enable it for entity types/bundles + every setting key (sidebar width, preview, toggle, color…)** →
  [configure/settings.md](configure/settings.md)
- **The five permissions and what each gates** →
  [permissions/permissions.md](permissions/permissions.md)
- **Routes, endpoints, the `paragraphs_helper` service, AJAX commands** →
  [api/endpoints-and-service.md](api/endpoints-and-service.md)
- **Alter hooks (`fe_field_wrapper_exclude_alter`, `fe_allowed_bundles_alter`) and the 3 access events** →
  [hooks/hooks-and-events.md](hooks/hooks-and-events.md)

Key facts:
- Which bundles are editable is stored at `frontend_editing.settings:entity_types` as a map
  `<entity_type_id>: [bundle, …]` (e.g. `node: [article]`). Set it on the "Entity types and
  bundles" form (`/admin/config/frontend-editing/entity-bundle-restrictions`).
- Three admin forms: main **SettingsForm**, **EntityTypesBundlesForm**, **UiSettingsForm**.
- No plugins, no Drush. Paragraph actions run through dedicated `/frontend-editing/paragraphs/*`
  routes, access-checked via `paragraphs_edit` and the module's access events.
