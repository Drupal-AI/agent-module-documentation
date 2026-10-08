# layout_library — agent start

Beta extension of core **Layout Builder**. Adds a `layout` config entity that stores reusable
Layout Builder sections scoped to a target entity type + bundle; content authors pick one from a
`layout_selection` select on the content form. Depends on `drupal:layout_builder`.
Config UI: **Admin → Structure → Layout library** (`/admin/structure/layouts`,
route `entity.layout.collection`).

- Create reusable layouts, enable the library on a bundle, let authors select → [configure/layout_library.md](configure/layout_library.md)
- Who can author layouts vs. select them → [permissions/layout_library.md](permissions/layout_library.md)
