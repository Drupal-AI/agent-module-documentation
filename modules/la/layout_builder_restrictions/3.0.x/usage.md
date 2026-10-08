Layout Builder Restrictions lets site builders control exactly which blocks, block categories, and layouts are available to editors within Drupal's Layout Builder, per entity view mode.

---

Core Layout Builder exposes every block and every installed layout to anyone editing a layout, which quickly overwhelms editors and lets them place things that break the design. This module adds a governance layer built around a pluggable **LayoutBuilderRestriction** plugin type. Its default plugin, `entity_view_mode_restriction`, adds a "Layout Builder Restrictions" section to each view mode's "Manage layout" defaults form, where a site builder whitelists or blacklists individual blocks, whole block categories (e.g. only "Content fields" and "Inline blocks"), and which layout plugins may be used. Restrictions are stored as third-party settings on the layout section storage, so they travel with exported configuration. The module hooks into Layout Builder's block-chooser and move-block flows (via controllers and a route subscriber) so disallowed blocks never appear and cannot be dragged into a region. A global admin page (`/admin/config/content/layout-builder-restrictions`) lets you enable, disable and order the available restriction plugins. Developers can implement additional restriction strategies by writing a plugin that alters block and layout definitions and validates block moves. The bundled "By Region" submodule extends this to per-region granularity.

---

- Limit editors to a curated set of blocks in Layout Builder.
- Allow only "Inline blocks" and "Content fields", hiding system blocks.
- Whitelist specific blocks per entity view mode.
- Blacklist a handful of problematic blocks while allowing the rest.
- Restrict which layout plugins (1-col, 2-col, etc.) editors may choose.
- Enforce a consistent design system across content authored in Layout Builder.
- Prevent editors from placing views or menu blocks into content.
- Reduce editor overwhelm by trimming a huge block list to the essentials.
- Configure different restrictions for full vs teaser view modes.
- Ship restrictions as exportable third-party config across environments.
- Stop disallowed blocks from being dragged into a region during a move.
- Restrict allowed inline block types (custom block bundles).
- Enable/disable/order restriction plugins from a central admin page.
- Gate restriction configuration behind a dedicated permission.
- Combine multiple restriction plugins with weighted precedence.
- Provide per-region restrictions using the "By Region" submodule.
- Lock down a landing-page content type to approved components only.
- Keep marketing components out of article body layouts.
- Give a design team control while letting authors still arrange approved blocks.
- Write a custom restriction plugin for project-specific rules.
- Restrict layouts and blocks based on the entity being edited.
- Ensure only accessible/branded layouts are used site-wide.
- Prevent accidental placement of debugging or admin blocks in content.
