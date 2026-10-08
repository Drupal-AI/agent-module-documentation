<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Automation makes selecting one entity reference on a content form automatically fill in the values of other entity reference fields.

---

Entity Reference Automation (er_auto) lets a site builder link entity reference fields so that a content editor's choice in one field cascades into others. On an entity reference field's configuration form you enable automation, pick one or more "source" reference fields that live on the *referenced* entity, and pick the "automated" reference fields on the *host* bundle that should receive their values. When the editor then changes the driving field on the node/entity edit form, the module (via a JavaScript behavior) copies the reference IDs from the chosen entity's source fields into the automated fields, and removes them again when the choice is de-selected. The copy happens in the browser so the editor can review and adjust the pre-filled values before saving; nothing is applied to fields that are not present or not selectable on the form, and the entity is still saved through Drupal's normal form submission and access checks. It targets standard `entity_reference` fields whose target is a fieldable content entity type, and works with select, radio, and checkbox reference widgets (including Chosen-enhanced selects). It has no settings page of its own; all configuration is stored as third-party settings on the individual field.

---

- Auto-assign a new issue to its project's owner when the editor picks the project.
- Pre-fill an article's access-control taxonomy terms based on the chosen category.
- Copy default editorial roles onto content from the selected content category.
- Attach a set of "Event" tags automatically when "Party" is chosen on a blog post.
- Populate a "team members" reference from the selected department entity.
- Default a document's audience terms ("end user" vs. "API") from its knowledge-base topic.
- Cascade a product's related-accessory references from the chosen product line.
- Suggest reviewer users automatically when a work item's project is selected.
- Keep two parallel taxonomies (filtering vs. access) in sync from one editor choice.
- Reduce repetitive multi-field data entry on complex content types.
- Pre-select recommended tags when a primary category term is chosen.
- Fill a "region" reference automatically from the selected office location.
- Provide editors with sensible reference defaults they can still override before saving.
- Drive checkbox/radio reference widgets from a source select field.
- Automatically build course-prerequisite references from the chosen course.
- Set default committee memberships from a selected governing body.
- Populate contact references from a chosen organization node.
- Add default distribution-list references when a newsletter section is selected.
- Copy owner/maintainer references from a parent entity down to child items.
- Keep an editor focused on the primary topic while related references self-populate.
- Remove auto-added references cleanly when the driving selection is unchecked.
- Support multi-value source fields so several targets can be filled at once.
- Configure the behavior per field with no site-wide settings to manage.
- Work with Chosen-enhanced select widgets by triggering their update event.
