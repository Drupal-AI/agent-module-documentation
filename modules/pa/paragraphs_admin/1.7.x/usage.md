<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Paragraphs Admin adds an administrative overview of every Paragraph entity on the site (at `/admin/content/paragraphs`) plus the ability to delete individual paragraphs, which core and the Paragraphs module do not expose on their own.

---

Paragraphs Admin is a small companion to the contrib **Paragraphs** module. Enabling it installs a **View** (`paragraphs`) that lists all paragraph entities at `/admin/content/paragraphs`, gated by the module's single permission **`administer paragraphs`** (a *restricted access* permission). The listing includes a custom Views field, **Host Entity** (`paragraphs_host_entity`), that walks up the paragraph's parent chain to the top-level content entity and renders a link to it — or, when the top parent is itself a Paragraph with no canonical URL, shows the unlinked label to flag likely **orphaned** paragraphs. The module also registers a **delete form** for the paragraph entity type (route `paragraphs_admin.delete_form` at `/paragraph/{paragraph}/delete`, access `paragraph.delete`) so administrators can remove stray or orphaned paragraphs directly. It defines the field handler via `hook_views_data_alter()`, sets the delete form class via `hook_entity_type_build()`, and ships a post-update that switches the shipped view's access from `access content` to `administer paragraphs`. There is no settings form, no configure route, and no Drush.

---

- See a single table of every Paragraph entity on the site at `/admin/content/paragraphs`.
- Find and clean up **orphaned** paragraphs whose host content was deleted.
- Delete an individual paragraph entity via `/paragraph/{id}/delete`.
- Identify which node/entity a given paragraph belongs to via the Host Entity link.
- Audit how many paragraphs of each type exist across the site.
- Grant a content-admin role the `administer paragraphs` permission to manage paragraphs.
- Trace a nested paragraph up to its top-level host content.
- Spot paragraphs that render an unlinked host label (a sign of orphaning or a paragraph-in-paragraph top parent).
- Add the "Host Entity" field to a custom Paragraphs view to show parent links.
- Build a moderation queue of paragraphs filtered by type or author.
- Provide editors a central place to review structured paragraph content.
- Remove leftover paragraphs after migrating or restructuring content types.
- Bulk-review paragraphs before a content cleanup.
- Restrict paragraph management to trusted admins via the restricted permission.
- Link from the paragraph overview straight to the host node's canonical page.
- Debug Paragraphs data integrity issues on a large site.
- Locate paragraphs referenced by an entity that no longer exists.
- Give site builders a Views base (`paragraphs_item_field_data`) to clone and customise.
- Surface paragraph counts for reporting/dashboards.
- Delete a specific paragraph flagged during QA without editing its host entity.
- Manage paragraphs on entity types beyond nodes (any host entity type is resolved).
- Extend the shipped `paragraphs` view with extra fields, filters, or exposed sorts.
