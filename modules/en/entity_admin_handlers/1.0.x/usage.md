<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Admin Handlers gives custom entity types a Field UI admin interface through reusable route-provider and links handlers, so you don't write that boilerplate yourself.

---

Entity Admin Handlers is a developer module. It ships ready-made entity-type handler classes — route providers, links providers, and small controllers — that you reference from a custom entity type's annotation or attribute to produce a working admin management area. Where core's own admin route provider doesn't fit an entity type's shape, these handlers create the "field UI base" route (and, for multi-bundle types, a bundle-listing page) that Field UI hangs its Manage fields / Manage form display / Manage display tabs off. Two configurations are covered: single-bundle (bundleless) entity types that work like the core user entity, and "plain bundle" entity types whose bundles come from code (hook_entity_bundle_info() or Entity API bundle plugins) rather than a config bundle entity. It depends on core Field UI, and full menu/task/action links require the core patch at drupal.org issue 2976861; the routes work without it. Every generated route is gated by the entity type's own admin permission.

---

- Give a bundleless custom content entity type a Field UI settings page without hand-writing a route provider.
- Give a multi-bundle content entity type (with code-defined bundles) an admin overview that lists its bundles.
- Replace the `html` route provider that Module Builder scaffolds with a set from this module.
- Add Manage fields, Manage form display, and Manage display tabs to a custom entity type via Field UI.
- Provide the `entity.ENTITY_TYPE.field_ui_base` route that Field UI's route subscriber expects.
- Expose an admin structure page for an entity type under Administration → Structure.
- Manage fields on an entity type whose bundles are derived from Entity API bundle plugins.
- Manage fields on an entity type whose bundles are hardcoded in hook_entity_bundle_info().
- Attach a per-bundle field settings page to each bundle of a plain-bundle entity type.
- Reuse a consistent admin UI pattern across several custom entity types in a project.
- Reduce custom module code needed to make a new entity type administrable.
- Provide menu and local-task links for a custom entity type's field settings (with the core patch).
- Ship an entity type in a contrib or custom module that behaves like core's user entity for field management.
- Give site builders a place in the admin UI to add fields to a code-defined entity type.
- Wire a custom entity type's `field_ui_base_route` property to a generated route.
- Provide a bundle list page with operation links straight to each bundle's field/form/display admin.
- Prototype a new entity type quickly, deferring a full config bundle entity type.
- Standardize how custom entity types integrate with Field UI across a codebase.
- Add an admin field-settings interface without defining an EntityListBuilder for that purpose.
- Serve as example/reference code for writing custom entity route providers and links providers.
