<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Synchronizer exports content entities (nodes, terms, files, paragraphs, users…) into a portable `tar.gz` archive and imports them into another Drupal environment, so you can move real content between prod, staging and dev.

---

The module models two content entity types: an **Export entity** (a reusable, named set of entities you want to ship) and an **Import entity** (an uploaded archive you run into the site). Its central `content_synchronizer.manager` service drives everything — building an archive from an Export entity or an ad-hoc entity, and creating/launching an Import from a `tar.gz` path. Under the hood it walks each entity's fields recursively via two plugin types: **entity_processor** plugins (keyed by entity type — Node, User, TaxonomyTerm, File, Paragraph, plus a default) decide how an entity is serialized, and **type_processor** plugins (keyed by field item class — entity reference, entity-reference-revisions, file, layout builder…) decide how each field is followed so referenced entities are pulled into the archive too. A `GlobalReferenceManager` maps every exported entity to a stable UUID/global id so references reconnect on the far side and updates target the right existing entity. Imports offer a **publish** strategy (`publication_publish` / `publication_unpublish` / `publication_revision`) and an **update** strategy (`update_systematic` / `update_if_recent` / `update_no_update`) so you control what happens to already-present content. Everything is available from a **dashboard** at `/admin/content_synchronizer` (Exports and Imports collections under *Content*), from bulk-export **actions**, from a Quick Export controller, and from **Drush** commands for CI/headless use. Permissions separately gate the dashboard, and creating/administering/viewing Export and Import entities. It requires the `cocur/slugify` PHP library and core's `file` module.

---

- Move a set of curated nodes from a staging site to production as a single archive.
- Push newly authored content from a content-editing environment to the live site.
- Pull real production content down into a developer's local for debugging.
- Build a reusable "Export entity" of the pages that make up a launch and re-export on demand.
- Quick-export a single node to a `tar.gz` straight from its page via the Quick Export link.
- Bulk-export many selected nodes at once using the "Export entity" action in a Views listing.
- Export a taxonomy term and automatically include the entities it references.
- Ship paragraphs and their host nodes together, preserving entity-reference-revisions links.
- Include referenced files/media in the archive so images travel with their content.
- Import an archive and publish everything on creation (publication_publish).
- Import content but leave it unpublished for review before it goes live (publication_unpublish).
- Import as new revisions of existing content (publication_revision) to keep history.
- Re-import updated content and overwrite existing entities every time (update_systematic).
- Re-import but only overwrite when the incoming content is more recent (update_if_recent).
- Import new content while never touching entities that already exist (update_no_update).
- Automate content deployment in CI with `drush content:synchronizer-launch-export` / `-launch-import`.
- Create an Import entity from an archive path in a script, then launch it non-interactively.
- Keep UUID-stable references across sites so relationships reconnect after import.
- Clean up leftover temporary export/import files with `drush content:synchronizer-clean-temporary-files`.
- Export one arbitrary entity by type+id with `drush content:synchronizer-export-entity node 123`.
- Add a custom entity_processor plugin to change how a specific entity type is serialized.
- Add a custom type_processor plugin to control how a custom field type's references are followed.
- Grant editors dashboard access while restricting who may administer Export/Import entities.
- Stage a whole content model (nodes + terms + files + users) as one portable bundle.
- Synchronise demo/seed content into fresh environments repeatably.
- Hand a `tar.gz` of content to another developer to import into their own environment.
