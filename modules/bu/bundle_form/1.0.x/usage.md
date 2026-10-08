<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bundle form lets you replace or customize a content-entity add/edit form for a specific bundle by writing a plugin, instead of a bundle switch inside hook_form_alter.

It registers a `bundle_form` plugin type (managed by `plugin.manager.bundle_form`) and swaps the form handler of supported entity types so each plugin's `overrideForm()` runs for the entity type + bundle it is annotated with. For node and taxonomy term it replaces the default/edit form class (`Form\NodeForm`, `Form\TermForm`, both using `BundleFormTrait`); for paragraphs it hooks the Paragraphs field widget (`Hook\FormHooks`). Plugins extend `BundleFormPluginBase`, declare their `entity_type`, `bundle` and `weight` in the `@BundleForm` annotation, and mutate the render array (add/remove/reorder elements, toggle `#access`, add submit/validate handlers). Multiple plugins can target the same bundle and run in weight order. The `bundle_form_examples` submodule ships copy-ready examples for node, term and paragraph bundles. It is a developer/site-builder tool with no routes, permissions, admin UI or config of its own.
---
Write a per-bundle form plugin (`@BundleForm` with entity type + bundle) that customizes one bundle's add/edit form; the module dispatches to it automatically.
---
- Give the Article node type a different edit form from Page
- Add custom fields or markup to a single content type's form only
- Reorder or regroup fields for one bundle without touching others
- Apply bundle-specific validation without a global form_alter switch
- Hide a field on one bundle's form via `#access` = FALSE
- Re-enable a field for a specific bundle with a low-weight plugin
- Override a taxonomy term bundle's form (e.g. Tags)
- Customize a Paragraph type's subform inside the Paragraphs widget
- Provide a distinct onboarding form variant for a bundle
- Keep bundle form logic in its own class instead of hook_form_alter
- Run several overrides on one bundle in a defined weight order
- Copy an example plugin from bundle_form_examples as a starting point
- Extend `BundleFormPluginBase` to reuse shared behaviour across plugins
- Target a form precisely by entity type + bundle via the annotation
- Add a submit or validate handler scoped to a single bundle
- Access the current entity inside the override (node/term forms)
- Ship bundle form plugins bundled inside a feature/module
- Add support for another entity type by overriding its form class with `BundleFormTrait`
- Conditionally alter a bundle form based on new vs. existing entity
- Avoid a monolithic hook_form_alter that switches on bundle
