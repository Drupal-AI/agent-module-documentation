# menu_trail_by_path — agent start

Sets menu active-trail from the current URL path (not just direct menu links). Decorates core
`menu.active_trail`. No deps, no custom permissions. Global settings:
**Admin → Config → System → Menu Trail By Path**
(`/admin/config/system/menu_trail_by_path/settings`, route `menu_trail_by_path.settings`,
permission `administer site configuration`).

- Global settings + per-menu override → [configure/settings.md](configure/settings.md)
- How it overrides the core active-trail service → [extend/service-override.md](extend/service-override.md)
