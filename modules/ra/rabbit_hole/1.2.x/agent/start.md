# rabbit_hole — agent start

Controls what happens when a content entity is viewed at its canonical page: display,
access denied (403), page not found (404), or redirect. Base module is a framework; enable
a submodule (`rh_node`, `rh_media`, `rh_taxonomy`, `rh_user`, `rh_file`, `rh_group`,
`rh_commerce`, `rh_paragraphs_library`) to act on a given entity type. No standalone config
route — settings live on entity/bundle edit forms (the "Rabbit Hole settings" vertical tab).

- Configure behaviors & settings (action, override, redirect, fallback) → [configure/settings.md](configure/settings.md)
- Plugin types it defines (behavior + entity plugins) & how to add one → [plugins/plugins.md](plugins/plugins.md)
- Services & how the action is performed → [api/services.md](api/services.md)
- Alter hooks (values & response) → [hooks/hooks.md](hooks/hooks.md)
- Per-entity-type permissions → [permissions/permissions.md](permissions/permissions.md)
