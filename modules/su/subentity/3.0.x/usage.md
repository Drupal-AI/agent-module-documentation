<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sub Entity is a developer framework for **subentities** — content entities that never exist on their own but are always referenced by a parent entity, so a subentity's access is derived from that parent instead of being decided independently. It is the field_collection idea generalised for Drupal 8+, and an alternative to Paragraphs when the Paragraphs type system, widget or revision model is the wrong shape.

---

You do not enable a subentity type; you define one in your own module as a content entity whose class extends `Drupal\subentity\Entity\SubEntityBase` and whose annotation wires the module's handlers — `ReferencedEntityAccessControlHandler` for access, `EntityParentHandler` (handler key `parent`) to locate parents, `EntityHtmlRouteProvider`/`BundleHtmlRouteProvider` for routes, `ReferencedEntityListBuilder`/`BundleListBuilder` for admin listings, and `ReferencedEntityForm`/`EntitySettingsForm`/`BundleForm` for forms. The fastest path is the Drush generator `drush generate subentity`, which — unlike `drush generate content-entity` — writes the class, routing, menu/task links and an optional `hook_update_N` into an existing module rather than creating a new one; run `drush updb` (or call `SubentityHelper::installSubentity()`) to install the base table. A subentity is attached to a parent simply by adding an `entity_reference` (or `entity_reference_revisions`) field on the parent that targets the subentity type; the access handler then finds every such parent and grants an operation on the subentity only when a parent grants the same operation to the user. The single permission `administer subentities` gates the admin UI at `/admin/structure/subentities` (with `administer site configuration`), while per-record access stays inherited from the parent. Core is `^10 || ^11` and Composer requires Drush > 11.

---

- Model repeated structured data that belongs to a parent entity.
- Build order-line, spec-sheet or survey-answer style child records.
- Choose a lightweight alternative to Paragraphs for composite data.
- Bring the field_collection pattern to Drupal 10/11.
- Derive a child entity's access from its parent entity.
- Keep child records out of the main content admin list.
- Scaffold a new subentity content entity with one Drush command.
- Generate a bundleable subentity (config bundle + schema) non-interactively.
- Add subentity boilerplate into an existing module instead of a new one.
- Install a generated subentity's schema from a `hook_update_N`.
- Attach a subentity to any parent via an entity-reference field.
- List subentities with their referencing parent shown in a Parent column.
- Give editors an admin UI to CRUD subentities under Structure.
- Restrict subentity administration behind `administer subentities`.
- Reuse a subentity type across several parent entity types.
- Make a subentity translatable and/or revisionable from the generator.
- Auto-theme a subentity type with the shipped `subentity` template.
- Override subentity markup with per-bundle / per-view-mode template suggestions.
- Prototype a composite data model quickly without hand-writing entity code.
- Replace a bespoke hand-built child entity type with a supported framework.
