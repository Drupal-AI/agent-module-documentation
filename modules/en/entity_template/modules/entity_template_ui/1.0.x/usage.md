<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
The admin UI submodule of Entity Template for configuring builders, blueprints, templates and components.

---

Entity Template UI is the configuration front-end for the Entity Template engine. It attaches admin routes, entity forms, list builders and menu/action links for the `entity_template_builder` and `entity_template_blueprint` config entities, and it provides the multi-step interface for editing the templates and components inside a blueprint (using a shared tempstore so edits can be assembled before saving). It also registers the `_blueprint_storage_access` route access check, a template-UI factory service, an "available placeholders" form element, and the PluginForms used to add and configure templates and components. It has no configuration of its own and requires the base `entity_template` module.

---

- Add and edit template builders at `/admin/content/entity_template/builder`.
- Add and edit template blueprints at `/admin/content/entity_template/blueprint`.
- Reach the config UI from the admin Content menu ("Templates").
- Build up a blueprint's templates step by step before saving.
- Choose a template plugin for a blueprint.
- Add, configure, swap and remove components on a template.
- Add and configure applicability conditions on a template.
- Edit a builder's default blueprint for supplying default field values.
- See the placeholders and filters available in a component's context while editing it.
- Configure an inline (sub) template on an entity reference field through dedicated forms.
- Use entity-autocomplete inputs when selecting entity data for a component.
- Provide the admin experience without exposing it to sites that only need the runtime engine.
- Manage template config entities through standard Drupal entity add/edit/delete forms.
- Delegate blueprint editing via the base module's builder/blueprint permissions.
- Keep the configuration UI as an optional, separately enableable submodule.
