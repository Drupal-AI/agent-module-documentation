# dashboard — agent start

Configurable admin dashboards for Drupal 11. Each dashboard is a `dashboard` config entity
whose `layout` you build with Layout Builder from blocks; the module shows each user the
first enabled dashboard they may view. Contrib successor to core's removed Dashboard module.
Depends on core `layout_builder`, `node`, `views`. Manage at **Admin → Structure → Dashboard**
(`/admin/structure/dashboard`, route `entity.dashboard.collection`); user page `/admin/dashboard`.

- Create dashboards, place blocks/layout, per-role access & login landing → [configure/dashboard.md](configure/dashboard.md)
- Permissions (`administer dashboard` + dynamic `view <id> dashboard`) → [permissions/dashboard.md](permissions/dashboard.md)
