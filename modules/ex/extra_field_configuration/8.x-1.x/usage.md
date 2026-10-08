<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a configuration layer over the Extra Field module so site builders can place extra (pseudo-) fields onto entity displays through config entities instead of plugin annotations.

---

Extra Field Configuration extends the Extra Field contrib module. Plain Extra Field expects each plugin to hard-code the entity types/bundles it appears on in its `@ExtraFieldDisplay` annotation's `bundles` property; this module instead lets you create `ExtraFieldConfiguration` config entities from an admin screen at `/admin/structure/extra-field` that bind a plugin to any fieldable entity type and bundle. Because each config entity is a named instance, the same plugin can be reused many times on one entity without writing duplicate plugin classes. A plugin becomes configurable simply by adding `deriver = "Drupal\extra_field_configuration\Plugin\Derivative\ExtraFieldConfigurationDeriver"` to its annotation and omitting `bundles`; `ExtraFieldConfigurationDisplayManager` (a subclass of Extra Field's manager) then discovers those plugins, the deriver turns each saved instance into a derived plugin definition, `hook_entity_extra_field_info()` exposes it on the *Manage display* screens, and `hook_entity_view()` renders it. All create/edit/delete operations are gated by the `administer extra fields` permission. The generated field/template name is `extra_field_{machine_name}`. An optional `extra_field_configuration_examples` submodule ships two ready-to-use sample plugins, and Extra Field Plus plugins are also supported.

---

- Attach an Extra Field plugin to an entity display through the UI instead of editing plugin annotations.
- Reuse the same extra field plugin multiple times on one entity as separate named instances.
- Create, edit, and delete extra field instances at `/admin/structure/extra-field`.
- Bind an extra field to multiple entity types and bundles from one configuration form.
- Let site builders (not just developers) manage where a pseudo-field appears.
- Add computed / plugin-generated output to node, block_content, paragraph, user, taxonomy or any fieldable entity display.
- Ship extra-field placement as exportable configuration (config entity `extra_field_configuration.display.*`).
- Move an existing Extra Field plugin off annotation-based placement by adding the deriver and dropping `bundles`.
- Use Extra Field Plus plugins under a configuration-driven placement workflow.
- Enable the examples submodule to get ExampleField / ExampleFormattedField plugins to experiment with.
- Toggle each instance's bundles per entity type via checkboxes (priority entities node/block_content/paragraph shown first, others under "Advanced").
- Look up the machine field name (`extra_field_{machine_name}`) to print an extra field in a Twig template.
- Give each placement a human-readable administration label distinct from its machine name.
- Provide the same extra-field plugin to several bundles at once from a single instance.
- Remove a placement cleanly (the delete confirm form lists every view display it currently appears on).
- Keep plugin class files and locations unchanged while switching to config-based placement.
- Refresh Manage-display forms automatically after saving/deleting an instance (module invalidates `entity_field_info` and clears extra-field caches).
- Build a library of reusable display widgets (calls-to-action, badges, computed summaries) placed by configuration.
- Grant a dedicated role the `administer extra fields` permission to delegate extra-field management.
- Distribute extra-field placements as part of a config-managed deployment.
- Expose developer-provided render output on entity view displays without touching code for each placement.
