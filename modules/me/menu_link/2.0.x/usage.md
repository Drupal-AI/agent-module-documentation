Menu Link (Field) provides a `menu_link` field type so any entity type — not just nodes — can place a link to itself into a menu, with the menu placement stored per revision.

---

The module defines a Field API field type `menu_link` that stores a menu link's `title`, `description`, target `menu_name`, `parent`, and `weight` in a fixed field table. Because it is a real field, it works on any fieldable entity, can differ per bundle, is exposed to Views, and — unlike core's Menu UI — is **revisionable** (title and menu placement are versioned with the entity). It ships a widget (`menu_link_default`) that renders a "Menu settings"-style form using core's menu parent selector, and two formatters: `menu_link` (renders the stored link, optionally as a hyperlink to the target) and `menu_link_breadcrumb` (renders the menu ancestry as a breadcrumb, optionally parents-only). Field storage settings expose `menu_link_per_translation`; field instance settings define `available_menus` (which menus a link may go into) and `default_menu_parent`. On node types it replaces core Menu module's "Menu settings" node-form section (it unsets `menu_ui`'s `form_node_form_alter`) and forces field cardinality to 1. Saving the field creates/updates a `MenuLinkField` menu link plugin; deleting the field item removes the plugin definition. Requires only core `field`; no permissions, Drush, or admin config page of its own (configuration is per field via Field UI).

---

- Let content editors add a page to a menu directly from the entity edit form via a field.
- Place non-node entities (taxonomy terms, custom content entities, media) into menus.
- Version a page's menu placement so reverting a revision also reverts its menu link.
- Track title and menu position per revision for editorial history/auditing.
- Expose menu placement to Views (menu name, title) because it is a real field.
- Use different menu widgets or formatters per content type / bundle.
- Restrict which menus a given bundle's links may be placed in (`available_menus`).
- Set a default menu + parent for new links of a bundle (`default_menu_parent`).
- Render a stored menu link as a plain label or as a hyperlink to the target (`link_to_target`).
- Output a breadcrumb trail from an entity's menu link using the `menu_link_breadcrumb` formatter.
- Show only the ancestors (parents) of a link as a breadcrumb (`parents_only`).
- Provide a menu link per translation when using content translation (`menu_link_per_translation`).
- Replace core's node "Menu settings" section with a field-based equivalent that supports fields UI.
- Build custom edit forms that include menu placement using the field widget.
- Add menu placement to a migration by mapping to the `menu_link` field.
- Group the menu widget into a vertical tab using the Field group module.
- Give a bundle a fixed single menu link (cardinality is locked to 1).
- Query/report on which entities are placed in which menus via the field's fixed table.
- Let editors set a menu link description (hover text) alongside the title.
- Order sibling links by editing the stored `weight` via the widget.
- Programmatically create menu links by setting the field value when saving an entity.
- Remove an entity's menu link automatically when the field item is deleted.
