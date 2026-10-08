# tvi — agent start

Taxonomy Views Integrator overrides taxonomy term-listing pages with a chosen View, set
per term, per vocabulary, or globally. It re-points the `entity.taxonomy_term.canonical`
route to its own controller and picks the View via a precedence chain. Depends on core
`views` and `taxonomy`. Global config UI: **Admin → Config → User interface → Taxonomy
Views Integrator** (`/admin/config/user-interface/tvi`); settings route `tvi.global_settings`.

- Assign a View+display per term / per vocabulary / globally, and the fallback order → [configure/tvi.md](configure/tvi.md)
- Permissions (global admin + per-vocabulary delegation) → [permissions/tvi.md](permissions/tvi.md)
