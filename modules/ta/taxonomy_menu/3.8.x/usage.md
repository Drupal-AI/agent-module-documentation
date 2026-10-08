Taxonomy Menu generates menu links from a taxonomy vocabulary's terms and keeps that menu in sync as terms are added, updated, and deleted.

---

Taxonomy Menu provides a `taxonomy_menu` configuration entity that maps one taxonomy vocabulary to one menu. When you create the entity you choose the vocabulary, the target menu, a maximum depth, an optional parent menu link, whether the entries are expanded, an optional term field to use as the menu-item description, and whether to order items by term weight. Saving the entity builds one menu link per term (mirroring the term hierarchy via each term's parent) through the core menu link plugin system: a derivative plugin (`TaxonomyMenuMenuLink` deriver) and a menu link plugin (`Plugin\Menu\TaxonomyMenuMenuLink`) render each link. The link title and description are rendered dynamically from the term (and its translation) rather than stored, so they always match the taxonomy. Core entity hooks in `taxonomy_menu.module` (`hook_taxonomy_term_insert/update/delete`) call the `taxonomy_menu.helper` service to add, update, or remove the corresponding menu link whenever a term changes, keeping the menu synchronized with the vocabulary. Menu items are decoupled after creation: you may reorder them, toggle expand/enable, but titles, descriptions, and parents are constrained to preserve the taxonomy tree. A `hook_taxonomy_menu_link_alter()` alter lets modules adjust each generated link definition. Config lives at Admin → Structure → Taxonomy menu (`entity.taxonomy_menu.collection`), gated by the core `administer site configuration` permission. Menu items are heavily cached, so a cache clear is often needed after bulk changes.

---

- Turn a "Categories" vocabulary into a navigable site menu automatically.
- Keep a menu in sync with a vocabulary so adding a term adds a menu link.
- Remove a menu link automatically when its taxonomy term is deleted.
- Update a menu link's title automatically when a term is renamed.
- Mirror a term hierarchy (parent/child terms) as nested menu items.
- Limit generated menu depth (1-9 levels) to avoid an overly deep menu.
- Attach a taxonomy-generated tree under an existing parent menu link.
- Place the generated links into any menu (main, footer, or a custom menu).
- Render all entries expanded so child terms show without clicking.
- Order menu items by term weight, or fall back to alphabetical order.
- Use a term field (e.g. a body/description field) as the menu-item description.
- Show translated term labels in the menu for multilingual sites.
- Hide a menu item automatically when its term is unpublished (status off).
- Build a product-category navigation from a commerce taxonomy.
- Create a documentation/topic browser from a topics vocabulary.
- Manage multiple vocabulary-to-menu mappings via separate config entities.
- Reorder or disable individual generated links without breaking the tree.
- Export the taxonomy_menu config entity between environments as configuration.
- Alter each generated menu link definition with `hook_taxonomy_menu_link_alter()`.
- Reverse-look-up which taxonomy menus target a given vocabulary via the helper service.
- Regenerate all links for a vocabulary programmatically after a bulk term import.
- Drive a mega-menu whose structure follows an editorial taxonomy.
