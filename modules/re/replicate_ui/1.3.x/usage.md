<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Replicate UI puts a user interface on top of the Replicate API: once you enable it for chosen content entity types, editors get a "Replicate" local task, entity-operation link, and confirmation form to clone any entity (with all its fields and child entities) directly from the site.

---

The Replicate module supplies a `replicate.replicator` service that deep-clones a content entity, but ships no interface. Replicate UI adds that interface. On its settings form (`/admin/config/content/replicate`) you tick which content entity types should be replicable; a dynamic route subscriber then registers an `entity.{type}.replicate` route at `/{type}/{id}/replicate` for each enabled type, adds a "Replicate" tab (local task) and entity-operation link, and sets a `replicate` link template and confirm form on those entity types. Clicking Replicate opens a confirm form that lets the editor set the new label (defaulting to "{label} (Copy)", per translation) before the clone is created and saved, then redirects to the copy. Access requires the `replicate entities` permission plus core create (and view) access on the entity type, with an optional toggle to also require edit access on the original. The module also exposes the clone operation as a core Action plugin (`entity_replicate`, usable in Views Bulk Operations), a Rules action (`replicate_ui_entity_replicate`), and a Views field (`replicate_ui_link`).

---

- Give editors a one-click "Replicate" tab on nodes to duplicate an article or page and edit the copy
- Clone complex content (paragraphs, media, referenced children) in one action via the underlying Replicate deep-clone
- Enable duplication for custom content entity types, not just nodes
- Let a content team spin up new landing pages from an approved template node
- Duplicate a taxonomy term (with its fields) as the basis for a new one
- Copy a user-authored entity while prompting the editor for a fresh label before saving
- Add a "Replicate" bulk operation to a View using the `entity_replicate` action plugin (Views Bulk Operations)
- Provide a Replicate link column in a custom View via the `replicate_ui_link` Views field
- Trigger entity replication from a Rules reaction/component with the `replicate_ui_entity_replicate` action
- Restrict who can duplicate content with the `replicate entities` permission per role
- Require that a user can also edit the original before allowing them to replicate it (`check_edit_access`)
- Duplicate media entities to reuse an asset with different metadata
- Clone block content (custom blocks) to build a variant without rebuilding it
- Seed test/sample content quickly by replicating an existing representative entity
- Give marketers a self-service way to copy campaign pages without developer help
- Duplicate commerce or catalog-style entities as a starting point for similar items
- Standardize new content on a "master copy" that editors replicate and tweak
- Offer per-language label fields on the confirm form so translated entities get sensible copy labels
- Expose replicate only on the entity types you choose, keeping the UI uncluttered elsewhere
- Combine with permissions so only trusted roles see the Replicate tab and operation
- Replicate an entity programmatically from custom code by calling `replicate.replicator`
- Build editorial workflows where "duplicate then edit" replaces re-authoring from scratch
- Let site builders enable/disable replication per entity type from config, no code required
- Add duplication to reference-heavy content (e.g. a page with many embedded paragraphs) safely
- Use the entity-operation "Replicate" link on admin content listings for fast duplication
- Clone an entity and immediately land on the new copy's canonical page to continue editing
