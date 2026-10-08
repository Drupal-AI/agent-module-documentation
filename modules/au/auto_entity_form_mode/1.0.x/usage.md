Auto entity form mode automatically registers every custom entity form mode as a usable form handler class, so custom code can build a form for that mode without writing a `hook_entity_type_build()`.

---

In Drupal, creating a custom entity form mode (via *Structure → Display modes → Form modes*, or a `core.entity_form_mode.*` config entity) makes the mode available for *Manage form display* configuration, but it does not automatically give the entity type a form handler class for that mode. As a result, calling `\Drupal::service('entity.form_builder')->getForm($entity, 'my_custom_form_mode')` throws `InvalidPluginDefinitionException` ("the entity type did not specify a form class") unless a developer manually copies the default form class onto the mode with a hook. This module enables that missing wiring globally: a single `hook_entity_type_alter()` walks every entity type, reads its `core.entity_form_mode.*` config entities directly from the config factory, and registers a form handler class for each mode — reusing the entity type's existing `default` form class — unless a class for that mode already exists. Once enabled, any custom form mode "just works" with the standard entity form builder, no per-mode hook required. The module has no UI, no settings, no permissions, no routes, and no dependencies beyond Drupal core.

---

- Use a custom form mode with `entity.form_builder`'s `getForm($entity, 'my_form_mode')` without writing a registration hook first.
- Build an alternate node edit form (fewer/reordered fields) for a custom form mode and render it in your own controller.
- Expose a stripped-down user edit form via a custom form mode in a custom route or block.
- Render a taxonomy term form in a custom form mode from a custom module.
- Provide a "quick edit" style form mode for a content entity and load it programmatically.
- Add a specialized create/edit form for a media entity form mode used only in custom code.
- Register form modes for custom content entity types automatically alongside core ones.
- Avoid boilerplate `hook_entity_type_build()`/`hook_entity_type_alter()` code across many modules that each define a form mode.
- Let a form mode defined by another module or by site config become immediately usable in your code.
- Embed an entity form in a custom form mode inside a multistep or AJAX workflow.
- Drive a front-end "profile edit" experience using a dedicated user form mode.
- Provide role- or context-specific form layouts by configuring a form display per form mode, then loading the mode in code.
- Reuse the default form's validation and submit logic while presenting a different field layout per mode.
- Prototype form modes quickly during development without shipping a registration hook.
- Support form modes on config-exported sites where the mode config is imported but no code wires it up.
- Render an entity form for a custom mode inside a paragraph or layout builder custom block.
- Load a "moderation" or "review" form mode form from a custom controller.
- Make imported form modes from another environment usable without additional code changes.
- Standardize form-mode wiring behavior across a multisite platform by enabling one module everywhere.
- Support contrib or distribution modules that ship form modes but not their handler registration.
- Serve a compact mobile-oriented entity edit form via a dedicated form mode loaded programmatically.
