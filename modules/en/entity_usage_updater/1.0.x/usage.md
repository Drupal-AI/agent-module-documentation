<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Usage Updater lets an administrator update or remove references to a given entity everywhere they are tracked — for example, repoint every reference to node 21 so it points to node 42 instead, or strip links to an entity out of content.

---

It builds on the Entity Usage module, which records where each entity is referenced; this module reads that usage data and rewrites the referring content. A pluggable `EntityUsageUpdater` plugin type (annotation + attribute discovery) handles each kind of reference: `EntityReference` fields, HTML links in text fields (`HtmlLink`), core `Link` fields, and Linkit-generated links. The **Update entity references** form (`/admin/content/update-references`) takes a source entity and a replacement id and updates all tracked references; the **Link remover** form (`/admin/config/content/link-remover`) removes links to entities from content. Both are gated by the `update referenced entities` permission, which is flagged `restrict access: true` (a sensitive, admin-level capability because it mutates arbitrary content and can create new revisions). A settings form (`/admin/config/content/entity-usage-updater`, `administer site configuration`) configures the module and its plugins. It respects entity validation via a `ViolationsHelper` and works across revisions, paragraphs and content-moderation states (as covered by its test suite).

Typical setup: install and configure Entity Usage first (only tracked references can be updated), grant `update referenced entities` to trusted roles, then use the update/link-remover forms — ideally after a backup, since edits are applied directly to content.
---
- Repoint every reference from one entity to another (e.g. node 21 → 42)
- Bulk-update tracked entity_reference field values
- Update HTML links inside formatted-text fields to a new target
- Update core Link field values pointing at an entity
- Update Linkit links embedded in rich text
- Remove links to a specific entity from content via the Link remover
- Consolidate duplicate entities by merging their references
- Fix references before deleting an obsolete entity
- Migrate references during content restructuring
- Update references across entity revisions
- Update references inside Paragraphs
- Handle references on content-moderation-managed content
- Restrict the capability with the `update referenced entities` permission
- Configure which updater plugins run via the settings form
- Preview/validate updates against entity constraint violations
- Reach the tool from the Content admin menu tab
- Rely on Entity Usage tracking to find all reference locations
- Extend support with a custom `EntityUsageUpdater` plugin
- Clean up references left by redirect/alias changes
- Run reference updates as an administrative maintenance task
