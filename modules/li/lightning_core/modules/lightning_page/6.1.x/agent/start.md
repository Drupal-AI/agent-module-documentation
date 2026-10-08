# Basic Page (lightning_page) — agent index

Lightning Core submodule. Installs a `page` ("Basic page") node type for static content,
with optional Metatag / Pathauto / Layout Library / menu / workflow integrations that
activate only when those modules are present. Machine name `lightning_page`; depends on
`lightning_core` + `node`. No config UI of its own (`configure: null`) — manage the type
at `/admin/structure/types/manage/page`.

- **What it installs and the conditional integrations**:
  [configure/lightning_page.md](configure/lightning_page.md)

No permissions, plugin types, hooks API, or Drush commands. NOT compatible with the
Standard install profile (which already defines `page`).
