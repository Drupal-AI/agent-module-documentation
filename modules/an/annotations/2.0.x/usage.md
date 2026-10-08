<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Annotations is the base module of the Annotations suite: it defines the annotation content entity, the annotation_target and annotation_type config entities, a target plugin system, and the management/consumption permission model that every submodule builds on.

---

The base `annotations` module is a data + API layer, not an end-user feature. It provides the `annotation` content entity (editorial: fieldable, revisionable, translatable, publishable, workflow-ready), the `annotation_target` config entity that records which entity type + bundle is opted in for annotation and which of its fields are in scope, and the `annotation_type` config entity that acts as the annotation bundle (three defaults ship via config: editorial, technical, rules). Targets are described by `#[AnnotationsTarget]` plugins discovered from `src/Plugin/AnnotationsTarget/` of any module — dedicated plugins exist for node, taxonomy_term, user_role, media, menu, view, paragraph, workflow, and a `GenericTarget` deriver covers every other fieldable entity type. Annotation text is persisted only as content entities via `AnnotationStorageService` (never config sync), so it survives deploys and is editable on production. The access model splits administration (`administer annotations` / `administer annotation targets` / `administer annotation types`) from per-type consume/edit/delete permissions generated dynamically by `AnnotationsPermissions`. The suite's actual UIs, overlays, exporters, and AI/agent context endpoints live in the twelve submodules. Requires Drupal 11.2+ and core Views; admin overview at `/admin/config/annotations`.

---

- Define a shared data model for site-wide editorial notes and documentation.
- Attach structured annotations to content types, fields, and custom entities.
- Opt an entity type + bundle into annotation via an `annotation_target` config entity.
- Choose which fields of a target are in scope for annotation.
- Categorise annotations by type (editorial, technical, rules) via `annotation_type` bundles.
- Store annotation text as first-class content entities that survive config sync.
- Keep revisions of every annotation (EditorialContentEntityBase).
- Translate annotations per language.
- Attach a content-moderation workflow to annotations (via annotations_workflows).
- Discover annotatable entity types automatically through the `#[AnnotationsTarget]` plugin system.
- Provide a `GenericTarget` deriver so ECK / hand-rolled fieldable entities appear without custom code.
- Add a dedicated target plugin for a new entity type by dropping a class in `src/Plugin/AnnotationsTarget/`.
- Separate annotation administration from consumption in the permission model.
- Generate per-type `consume` / `edit` / `delete` permissions automatically for each annotation type.
- Gate the admin UI with `administer annotations` and target/type management with dedicated permissions.
- Query annotations for a target through `AnnotationStorageService` (default or latest revision).
- Clean up annotation rows automatically when a target or type is deleted.
- Expose derived Views fields/filters (target label, field label, type label, moderation state).
- Provide config actions (`EnableTargetType`, `EnableTargetField`) for recipes to opt targets in.
- Ship demo recipes (Umami, LocalGov, Webform, types) to bootstrap example annotations.
- Run Drush commands to list targets/types and show annotation content and stats.
- Serve as the foundation for overlays, coverage auditing, AI docs, and MCP/Tool context delivery.
