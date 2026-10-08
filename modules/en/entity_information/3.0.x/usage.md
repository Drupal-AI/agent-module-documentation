<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a pluggable "Information" tab to entities, where collapsible detail blocks supplied by EntityInformation plugins show metadata and related items for the viewed entity.

---

Entity Information registers an extra local-task tab (for example `/node/{node}/information`) on every entity type that has an edit form and at least one matching plugin. The tab renders one or more collapsible `details` blocks; each block is produced by an EntityInformation plugin that declares the entity-type/bundle combinations it targets, its label, weight and default open state, and builds a render array for the current entity. An admin settings form at `/admin/config/system/entity-information` lists all discovered plugins as checkboxes so a site can enable or disable each one, and two permissions ("view entity information", "administer entity information settings") gate viewing the tab and the settings form. The module ships two example plugins for nodes — a path-alias overview and a menu-link overview — and is primarily a developer framework: you add your own plugins under `Plugin/EntityInformation` to surface whatever entity metadata you need. Works on Drupal 10 and 11 with no non-core dependencies.

---

- Give editors a single "Information" tab that summarises metadata about a node or other entity.
- Show all path aliases that point to a node, with edit/delete operation links.
- List every menu link that references a node, showing title, menu and language.
- Build a custom plugin that displays an entity's revision count or last-changed date.
- Surface an entity's referencing entities (what links to this content) in a detail block.
- Add a block listing the URL redirects associated with a page.
- Expose translation status for a content entity in one place.
- Display workflow/moderation state history on an information tab.
- Provide an SEO metadata summary block for content editors.
- Show which webforms or views reference the current entity.
- Present file/media usage information for a media entity.
- Enable or disable individual information blocks per site from one settings form.
- Order detail blocks with the plugin `weight` property.
- Collapse rarely-used blocks by default via the plugin `open` property.
- Target a single bundle (`node.article`) or all bundles of a type (`node.*`) per plugin.
- Attach information blocks to non-node entity types (users, terms, media) that have an edit form.
- Restrict a specific block to certain users by implementing the plugin access interface.
- Give content teams quick edit/delete shortcuts to related menu links and aliases.
- Add an audit block summarising who created/changed an entity.
- Centralise "related administrative info" that would otherwise be scattered across screens.
- Prototype an internal entity inspector without writing a full controller or route.
- Extend the tab for custom entity types shipped by your own modules.
- Provide contextual reference data (e.g. linked commerce orders) on an entity's tab.
- Let developers reuse the two bundled plugins as templates for new plugins.
