<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Generic is a developer scaffolding module: reusable base classes and entity handlers that let a custom module define a full-featured content entity type with little boilerplate.

---

Entity Generic extends Drupal core's Entity system and the contributed Entity API (`entity`) module with a family of abstract base entity classes (`Basic`, `Simple`, `Generic`), status/lifecycle traits, and drop-in handler classes for storage, listing, viewing, forms, routing, permissions and access. A custom module marks a content entity type with an `entity_generic` key in its annotation and points its handlers at these classes; the entity type then automatically gains common base fields (created/changed, status, label, owner, and optional archived/deleted/approved flags with matching timestamps), a SQL storage handler and schema, a list builder with ID/created/changed columns, a themed view builder with template suggestions, standard and AJAX-modal add/edit/delete/toggle-status forms, a route provider that adds modal and merge-multiple routes, a permission provider and access control handler that reuse the Entity API module's granular per-operation permissions, Views data (autocomplete/select ID filters, modal-operation link fields), and derived VBO-style action plugins for the lifecycle flags. It is aimed at module developers building their own entity types and is described by its maintainers as experimental; it depends on `entity` and supports Drupal 9, 10 and 11.

---

- Scaffold a custom content entity type without hand-writing every handler class.
- Give a new entity type standard base fields (created, changed, status, label, owner) automatically.
- Add an "archived" lifecycle (boolean flag + archived-time timestamp) to a custom entity.
- Add an "approved"/moderation-style flag (approved + approved-time) to a custom entity.
- Add a soft-delete "deleted" flag (flag_deleted + deleted-time) instead of hard deletes.
- Reuse the Entity API module's granular per-bundle, own/any permission model on a custom entity.
- Extend `Basic`, `Simple` or `Generic` as the base class for a new content entity.
- Provide a Views-ready entity with an ID-autocomplete and ID-select exposed filter.
- Add "edit in modal", "delete in modal" and "toggle status in modal" links as Views fields.
- Offer AJAX modal add/edit/delete forms (`GenericModalForm`, `GenericModalController`) for a slick admin UI.
- Give editors bulk actions to enable/disable, approve/unapprove, archive/unarchive or mark/unmark deleted entities.
- Ship a themeable default entity template (`entity-generic.html.twig`) with per-type/per-bundle/per-view-mode suggestions.
- Provide a bulk "delete multiple" confirmation flow for entities that have a collection route.
- Build an admin collection listing with created/changed columns and a destination-aware edit link.
- Expose a manager service pattern (`GenericManager`) to load, list, and option-map entities for select widgets.
- Generate an AJAX "Add new entity" modal button programmatically from a manager.
- Define a config-entity bundle type (`GenericType`) with description, help and new-revision defaults.
- Redirect a single-bundle "add" page straight to the add form, or show an add-list otherwise.
- Store lifecycle flag columns as indexed, not-null, defaulted columns via a custom storage schema.
- Migrate existing rows' bundle value automatically when a bundle machine name is renamed.
- Add a local task ("Entities") tab to entity administration via a derivative.
- Prototype experimental entity types quickly in a developer or staging environment.
- Standardize entity conventions across several custom entity types in one project.
- Reduce duplicated boilerplate when a project defines many similar content entity types.
