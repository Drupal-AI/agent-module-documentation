# Menu Link (Field) — agent index

Field type `menu_link` that lets any fieldable entity place a revisionable link to itself into a
menu. Depends on core `field`. No config page (`configure` null), no permissions, no Drush. Provides
a config schema for its widget/formatter/storage/field settings.

- **The field type, widget, two formatters, and all storage/field settings + how to add the field** →
  [configure/field.md](configure/field.md)

Key facts:
- Field type `menu_link` (columns: `menu_name`, `title`, `description`, `parent`, `weight`);
  cardinality is forced to **1**. `list_class` = `MenuLinkItemList`.
- Widget `menu_link_default`; formatters `menu_link` (setting `link_to_target`) and
  `menu_link_breadcrumb` (settings `link_to_target`, `parents_only`).
- Storage setting `menu_link_per_translation`; field settings `available_menus`,
  `default_menu_parent`.
- On node forms it disables core `menu_ui`'s "Menu settings" section
  (`hook_module_implements_alter` unsets menu_ui `form_node_form_alter`).
- Saving a field item creates/updates a `MenuLinkField` menu-link plugin; deleting it removes the
  plugin definition. README documents helpers `menu_link_load_multiple()` /
  `menu_link_delete_multiple()`.
