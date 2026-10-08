# acquia_contenthub_curation — agent start

Adds a **discovery/curation UI** for Content Hub. Single admin route
`acquia_contenthub_curation.discovery` at `/admin/content/acquia-contenthub` (permission
`administer acquia content hub`, `_admin_route: TRUE`) that loads a JS discovery app (shipped as
a library) for browsing/curating syndicated content. No config form, no permissions of its own,
no Drush, no config schema. Requires `acquia_contenthub`.

No solution docs — the module exposes only this one UI route and no configurable/code surface.
