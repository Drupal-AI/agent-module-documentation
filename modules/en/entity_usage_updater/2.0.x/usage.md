<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Usage Updater lets an administrator update or remove references to a given entity everywhere they are tracked — for example, repoint every reference to node 21 so it points to node 42 instead, or strip links to an entity out of content. It also removes links identified by URL and can unpublish or change the moderation state of the affected entities.

---

It builds on the Entity Usage module (version 5.x / `^5.0@beta`), which records where each entity is referenced; this module reads that usage data and rewrites the referring content via the Batch API. A pluggable `EntityUsageUpdater` plugin type (`Plugin/EntityUsageUpdater`, discovered by both the `EntityUsageUpdater` attribute and the legacy annotation) handles each kind of reference: `entity_reference` fields, HTML links in text fields (`html_link`), core `link` fields, and Linkit-generated links (`linkit`). The **Update entity references** form (`/admin/content/update-references`) takes a source entity type + id and a replacement id and updates all tracked references through a confirm step; the **Link remover** form (`/admin/config/content/link-remover`) takes a list of URLs, resolves them to entities via Entity Usage's `UrlToEntity` helper, and removes the links — optionally unpublishing the targets or moving them to a chosen content-moderation state. Both forms are gated by the `update referenced entities` permission, flagged `restrict access: true` (a sensitive, admin-level capability because it mutates arbitrary content and can create new revisions). A `SettingsForm` (`/admin/config/content/entity-usage-updater`, `administer site configuration`) configures the updater plugins (e.g. the `html_link` plugin's "convert to Linkit" option) and, when content_moderation is enabled, a default unpublished state per workflow (stored as a workflow third-party setting). The module only ever rewrites the latest revision, respects entity validation via a `ViolationsHelper` (it refuses to save if it would add new constraint violations), walks Paragraphs trees inline (Entity Usage 5.x tracks paragraphs at the host level), and integrates with the Redirect module when removing links. A route subscriber swaps Entity Usage's usage-list controller so the update form is embedded directly on an entity's "Usage" tab.

Typical setup: install and configure Entity Usage 5.x first (only tracked references can be updated), grant `update referenced entities` to trusted admin roles, configure the updater plugins, then use the update / link-remover forms — ideally after a backup, since edits are applied directly to content and may create new revisions.
---
- Repoint every reference from one entity to another (e.g. node 21 → 42)
- Bulk-update tracked entity_reference field values
- Update HTML links inside formatted-text fields to a new target
- Update core Link field values pointing at an entity
- Update Linkit links embedded in rich text
- Remove links to a specific entity from content via the Link remover
- Remove links supplied as a list of URLs (resolved to entities automatically)
- Optionally unpublish entities whose links are removed
- Move moderated entities to a chosen content-moderation state when removing links
- Consolidate duplicate entities by merging their references
- Fix references before deleting an obsolete entity
- Migrate references during content restructuring
- Update references across entity revisions (only the latest revision is changed)
- Update references nested inside Paragraphs trees
- Handle references on content-moderation-managed content
- Follow and account for Redirect module entries when removing links
- Restrict the capability with the `update referenced entities` permission
- Configure which updater plugins run via the settings form
- Convert plain HTML links to Linkit links during an update (html_link plugin option)
- Set a default unpublished state per content-moderation workflow
- Skip updates that would introduce new entity constraint violations
- Reach the update form directly from an entity's Entity Usage tab
- Reach the tools from the Content and Configuration admin menus
- Rely on Entity Usage tracking to find all reference locations
- Extend support with a custom `EntityUsageUpdater` plugin
- Run reference updates as a batch-processed administrative maintenance task
