# taxonomy_menu — agent start

Generates menu links from a taxonomy vocabulary's terms via a `taxonomy_menu` config entity,
and keeps the menu in sync as terms are inserted/updated/deleted. Built on the core menu link
plugin system (a deriver + menu link plugin). Depends on core `taxonomy`. Config UI:
**Admin → Structure → Taxonomy menu** (`/admin/structure/taxonomy_menu`); collection route
`entity.taxonomy_menu.collection`, gated by core `administer site configuration`.

- Create/configure a taxonomy_menu (vocabulary→menu, depth, expanded, parent, order, description field) → [configure/settings.md](configure/settings.md)
- Programmatic links, term-sync helper service, and the alter hook → [api/api.md](api/api.md)
