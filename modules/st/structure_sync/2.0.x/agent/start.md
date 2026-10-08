# structure_sync — agent start

Exports content that acts like config — **taxonomy terms, custom (content) blocks, menu links** —
into the `structure_sync.data` config object, so it deploys with your site config and can be
imported back into entities on another environment. Fills the gap left by core CMI, which does not
move content entities. Depends on core `taxonomy`, `menu_link_content`, `block`. Admin UI:
**Admin → Structure → Structure Sync** (`/admin/structure/structure-sync`); configure route
`structure_sync.general.form`. No module-defined permissions — screens are gated by the core
`administer site configuration` permission.

- Admin screens, the `structure_sync.data` config object, import styles (safe/full/force) → [configure/structure_sync.md](configure/structure_sync.md)
- Drush export/import commands (per-type and export-all/import-all) → [drush/structure_sync.md](drush/structure_sync.md)
