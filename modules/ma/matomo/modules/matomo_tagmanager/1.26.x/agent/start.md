# matomo_tagmanager — agent start

Submodule of **matomo**. Injects Matomo Tag Manager (MTM) **container** snippets instead of
a fixed tracker. Containers are `matomo_tagmanager_container` config entities. Requires the
`matomo` module. Admin UI: **Admin → Config → System → Matomo → Tag Manager**
(`/admin/config/system/matomo/tagmanager`, route
`entity.matomo_tagmanager_container.collection`).

- Manage containers (add/edit/enable/disable/delete) → [configure/containers.md](configure/containers.md)
- Permission → [permissions/permissions.md](permissions/permissions.md)
