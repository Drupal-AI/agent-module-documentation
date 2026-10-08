<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs Admin — agent index

Adds an admin overview of all Paragraph entities plus per-paragraph delete. Companion to the
contrib **Paragraphs** module. No settings form, no configure route (`configure: null`), no Drush.

- **The paragraphs listing view, the Host Entity views field, and the delete route** →
  [configure/listing.md](configure/listing.md)
- **The `administer paragraphs` permission (what it gates)** →
  [permissions/administer-paragraphs.md](permissions/administer-paragraphs.md)

Key facts:
- Listing lives at `/admin/content/paragraphs` (shipped View machine name `paragraphs`,
  base table `paragraphs_item_field_data`), gated by `administer paragraphs`.
- Views field `paragraphs_host_entity` ("Host Entity") links to the top-level host entity;
  registered via `hook_views_data_alter()` on `paragraphs_item_field_data`.
- Delete: route `paragraphs_admin.delete_form`, path `/paragraph/{paragraph}/delete`, access
  `paragraph.delete` (delete form class set via `hook_entity_type_build()`).
- Depends on `paragraphs`, `user`, `views`.
