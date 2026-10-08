<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Configuration Entity View lets you build Views that list **configuration entities** — roles, menus, image styles, content types, views, text formats and so on — so those lists can be filtered, sorted, paged, exported, and reused like any other View.

---

The module registers Views data for every config entity type that has a list builder and a config prefix. For each such type it exposes a base table named `config_<prefix-with-dots-as-underscores>` (e.g. `node.type` → `config_node_type`, `user.role` → `config_user_role`, `image.style` → `config_image_style`, `system.menu` → `config_system_menu`), backed by a custom Views query plugin `views_config_entity_query` that runs the Entity Query API instead of SQL. It walks each type's config **schema** to expose typed fields as Views fields/filters/sorts (boolean, integer, or string), plus an **Operations** field (`config_entity_operations`). It ships ~14 ready-made Views that can *replace* core's admin list pages (Content types at `admin/structure/types`, Menus, Image styles, Taxonomy, etc.); some are enabled by default and others ship disabled so you can opt in. The Views add form is also grouped into **Content** vs **Configuration** wizards. Finally it provides an EntityReferenceSelection plugin, `config_views` ("Views: Filter by a Configuration View"), so an entity-reference field can use a config-entity View as its option source. It has no settings form, permissions, or Drush commands of its own.

---

- Build a filterable, sortable list of user roles as a View.
- List all content types with their descriptions and operation links in a custom page.
- Create an admin View of image styles that editors can search.
- Replace the core Content types listing (`admin/structure/types`) with a customizable View.
- Take over the Menus, Taxonomy, or Shortcuts admin list with a config View.
- Enable the shipped (disabled) Views for Text formats, User roles, View modes, or Views themselves.
- Export a list of config entities (e.g. via a Views data export display) for auditing.
- Page a long list of config entities with a Views pager.
- Add exposed filters so admins can search config entities by label or machine name.
- Sort config entities by a boolean or integer property exposed from their schema.
- Show an Operations (edit/delete) column on a config-entity listing via the operations field.
- Use a View of config entities as the option source for an entity-reference field (config_views selection).
- Reference specific content types, roles, or formats through a curated config View.
- Build a dashboard block listing menus or vocabularies.
- Audit which Views exist on the site with the `config_views_view` base table.
- Provide a custom admin overview page combining several config-entity fields.
- Filter content types by a schema boolean (e.g. new revision default) in a View.
- Create environment documentation pages that enumerate configuration.
- Give site builders a Views-driven alternative to hard-coded admin list builders.
- Restrict an entity reference to roles selected by a Configuration View.
- List date/time formats or comment types as a View for review.
- Add config-entity lists to an administrative Views dashboard.
- Expose config entity machine names as Views arguments for contextual pages.
- Standardise admin listings across a site by swapping in customizable config Views.
