<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Entity Builder lets you define custom content entity types and their base fields through the admin UI, register them dynamically at runtime, and optionally export them as a ready-to-install Drupal module.

---

Creating a content entity type in Drupal normally means hand-writing an entity class, its annotation, base field definitions, forms, list builder and access handler. Content Entity Builder replaces that boilerplate with a UI: you create a `content_type` config entity at `/admin/structure/content-types`, choose a mode (Basic, Basic Plus, Advanced or Full) that decides whether the type gets bundles, translation, ownership, publishing and revisions, then add base fields (string, text, number, boolean, email, telephone, datetime, entity reference, list, and more) from a pluggable field catalog. Saving with "Save and apply updates" writes the field storage to the database and registers the entity type in memory through `hook_entity_type_build` — no PHP is written to your codebase and no rebuild of your repo is needed. You then manage form/view display and per-type permissions with the normal Field UI and permissions pages, and add content at the paths you configured. When a prototype is ready to become maintained code, the Export tab scaffolds a complete module (entity classes, interfaces, forms, list builders, access control handlers, storage schema, routing, permissions and templates) and downloads it as a `.tar.gz`. The entire builder and export UI is restricted to the `administer content entity types` permission, so it is a developer/site-builder tool intended for trusted administrators. It is comparable to ECK.

---

- Create a custom content entity type from the admin UI without writing PHP.
- Prototype a new entity type and iterate on its fields quickly.
- Pick Basic mode for a single lightweight entity with one database table and no bundles.
- Pick Basic Plus when you need bundles on the entity type.
- Pick Advanced to get bundles, translation, an owner, changed and published fields.
- Pick Full to get a node-like entity with revisions on top of Advanced.
- Add string, text (plain, long, formatted) base fields to a custom entity.
- Add integer, decimal and float number base fields.
- Add boolean, email, telephone and datetime/timestamp base fields.
- Add entity reference base fields to link to other entities.
- Add list (integer/float/string) base fields with allowed-values options.
- Configure entity keys (id, uuid, label, bundle, langcode, published, owner, revision).
- Configure the entity's view/add/edit/delete paths, including an /admin-themed prefix.
- Apply the definition to the database with "Save and apply updates".
- Manage the entity's form and view display with the standard Field UI.
- Set granular per-type permissions (access, create, edit any/own, delete any/own) at admin/people/permissions.
- Build an internal data model (e.g. author, product, event) as first-class entities.
- Expose custom entities to Views for listings and filters.
- Export a built entity type to a downloadable Drupal module for version control.
- Graduate a UI-prototyped entity type into hand-maintained module code.
- Bundle several content types into one exported module in a single archive.
- Delete a content type to uninstall its entity type and drop its tables.
- Replace or complement ECK for custom content entities.
- Keep the builder restricted to trusted administrators only.
