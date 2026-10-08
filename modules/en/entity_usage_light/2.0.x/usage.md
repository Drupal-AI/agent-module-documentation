<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Usage Light adds a per-entity "Usage" tab that lists, on demand, the entities a given entity references.

---

Entity Usage Light is a lightweight alternative to the Entity Usage module. Instead of persistently tracking usage in a dedicated table, it computes the list of referenced entities live from an entity's current values whenever you open its "Usage" local-task tab. It works with any content entity type: you activate it per entity type on its settings form, then on each bundle's edit form you pick which referenced entity types the tab should detect (the classic choice is Media on nodes). Detection walks entity_reference and entity_reference_revisions fields, image/file fields, Paragraphs (including fields nested inside paragraphs), Layout Builder inline blocks, and entities embedded in text (CKEditor) fields; results are cached per host entity. When Views is available you can display each entity type through a chosen view, otherwise a default table is rendered. Access to the tab is governed by the module's own permission, and it depends on nothing outside Drupal core.

---

- See every media item a node uses, in one place, from the node's "Usage" tab.
- Enable a "Usage" tab on Article nodes and list all referenced media.
- Audit which files are attached to a content item before deleting it.
- Find all entities referenced from an entity_reference field on a bundle.
- Discover media embedded in CKEditor body text via data-entity attributes.
- Track down referenced entities nested inside Paragraphs components.
- List entities referenced through entity_reference_revisions fields.
- Surface Layout Builder inline block content referenced by a page.
- Give editors a quick reference overview without installing full Entity Usage.
- Configure which entity types the Usage tab detects, per bundle.
- Turn the Usage tab on for taxonomy terms, media, or any content entity type.
- Render referenced entities through a custom View instead of the default table.
- Fall back to a simple table listing when no matching View exists.
- Provide "view" and "edit" links (or list-builder operations) for each referenced entity.
- Show direct download links for referenced files.
- Restrict who can see the Usage tab with a dedicated permission.
- Let content authors review an article's media before publishing.
- Check referenced content across multiple selected entity types at once.
- Use it as a lighter stand-in for Entity Usage when full tracking is not needed.
- Enable usage reporting on a standard-profile site (Node + Media on by default after install).
- Cache the computed reference list for repeat views of the same entity.
- Point editors from the Usage tab straight to the bundle's configuration.
- Review referenced entities per bundle to plan content cleanup.
- Confirm which media a piece of content depends on when reorganizing the media library.
