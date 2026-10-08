<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Attach a PHP static method to a list/options field as its allowed-values callback by adding a #[AllowedValuesFunction] attribute, instead of editing field storage config or writing a hook.

---

Allowed Values Functions is a developer/site-builder tool for Drupal 11 that removes the boilerplate of pointing a list field (options, list_string, list_integer, entity reference with a callback, etc.) at a dynamic allowed-values function. Normally you set the `allowed_values_function` storage setting by hand — in the field's storage config YAML or through `hook_entity_field_storage_info_alter()`. With this module you instead add a repeatable `#[AllowedValuesFunction('<entity_type>', '<field_name>')]` attribute to a public static method in one of your custom modules. At container-compile time the module scans code for the attribute (via a service-provider autoconfiguration tag plus a compiler pass that token-scans non-service classes) and, through `hook_entity_field_storage_info_alter()`, sets each matching field's `allowed_values_function` setting to your `Class::method` callable. The method receives the field storage definition and the (optional) entity, exactly like core's native allowed-values callback, and returns the options array. A read-only report at `/admin/reports/fields/allowed-values-functions` (under Field storage tabs) lists every field-to-callable binding. The module has no settings form, no permissions of its own, no Drush commands, and no dependencies.

---

- Provide dynamic options for a list_string / list_integer / list_float field without hand-editing storage config.
- Replace a hand-written `hook_entity_field_storage_info_alter()` that only sets `allowed_values_function` with a single attribute.
- Bind one shared static method to the same field on several entity types using repeated attributes.
- Compute allowed values from other configuration or content (e.g. taxonomy terms, active languages, enabled payment methods).
- Return context-aware options that depend on the entity being edited via the optional `$entity` parameter.
- Centralize a set of "alignment" or "layout" option lists (left/center/right) used across node and paragraph fields.
- Keep option labels translatable by returning `t()`-wrapped strings from the callback.
- Move an existing allowed-values callback out of field YAML and into versioned, testable PHP.
- Audit which fields have a dynamic allowed-values function via the built-in report page.
- Discover, in one place, every `Class::method` callable wired to a field across all installed modules.
- Attach the callback to a base/bundle field defined in code without also editing its storage config.
- Let a module ship its own field and its allowed-values logic together in the same class.
- Generate options from an external-but-cached data source resolved inside the method.
- Vary select/radio/checkbox options per environment by branching inside the callback.
- Provide options for a Views exposed filter that reads a list field's allowed values.
- Ensure allowed values stay in sync with code deploys (no config edit needed after changing the method).
- Prototype dynamic field options quickly during development by dropping an attribute on a helper method.
- Serve options for entity-reference-style "select from a fixed set" fields defined via list fields.
- Keep allowed-values logic in a service class (autoconfigured) or a plain static helper class (compiler-pass scanned) — either works.
- Verify wiring after a `drush cr` by loading the report page and confirming the field/callable rows.
