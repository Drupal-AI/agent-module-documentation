<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field as Block turns any field of the entity being viewed into a placeable block, so a node's body, image or date can be rendered in a sidebar, header or footer region instead of inside the node template.

---

The module adds one block plugin, `fieldblock`, with a deriver that creates one derivative per *enabled entity type* — `fieldblock:node`, `fieldblock:user`, `fieldblock:taxonomy_term` out of the box, labelled "Content field", "User field", "Taxonomy term field" in the block library. Placing a derivative gives you a block form with four settings: **Use field label as block title** (`label_from_field`), the **Field** to render (`field_name`, from the entity type's *storage* definitions, so the list spans all bundles), the **Formatter** (`formatter_id`) and that formatter's own settings sub-form (`formatter_settings`) — all stored on the ordinary `block.block.*` config entity under `settings`. At render time `FieldBlock::getEntity()` walks the current route's `entity:*` parameters and picks the first one whose entity type matches the derivative, has a canonical link template and actually has the configured field; the block is then built with `$field->view(['label' => 'hidden', 'type' => …, 'settings' => …])` and translated into the current interface language. Access is denied when there is no matching entity, when the field is empty, or when field-level `view` access fails, so the block simply disappears on unrelated pages. Cache metadata is the entity's cache tags plus a `route` cache context. Which entity types get derivatives is controlled at `/admin/config/fieldblock/fieldblockconfig` (`fieldblock.settings:enabled_entity_types`, permission `administer fieldblock`), and that form also offers to delete orphaned blocks belonging to entity types that were switched off or removed.

---

- Render a node's body in a sidebar region instead of the main content area.
- Put a node's hero image into a full-width header region above the content.
- Show an article's "published on" date field in the page footer.
- Display a taxonomy term's description as a block on term pages.
- Put a user's profile picture in the sidebar of the user page.
- Show a product's price field in a sticky region while the body scrolls.
- Move a long "related links" field out of the node template into a dedicated region.
- Render the same field twice with different formatters (teaser text vs full text).
- Give a field its own block visibility conditions (path, role, content type).
- Show a field only on the entity's canonical page and nowhere else — automatic behaviour.
- Hide the block automatically when the field is empty (no empty wrapper markup).
- Use the field's own label as the block title with the `label_from_field` checkbox.
- Give a field block a custom block title instead of the field label.
- Place a field block inside a Block Layout region without touching Layout Builder.
- Expose an additional entity type (e.g. media, paragraphs' host) as field blocks via the settings form.
- Limit field blocks to just `node` on a site where user/term field blocks are noise.
- Clean up leftover field blocks after removing a custom entity type.
- Pick a specific formatter (e.g. `image` with a particular image style) per placement.
- Configure formatter settings such as trim length or date format inside the block form.
- Render a translated field value correctly on multilingual sites.
- Keep the correct cache tags so the block invalidates when the entity is saved.
- Combine with block visibility groups/conditions for per-section layouts.
- Show a term's custom field in a category landing page header.
- Build a "byline" region from an author reference field.
- Export block placements as config so field blocks ship with a deployment.
- Avoid a custom preprocess/template just to move one field to another region.

