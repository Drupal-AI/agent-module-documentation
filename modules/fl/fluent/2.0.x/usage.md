<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Fluent is a developer experience library that lets you resolve values out of fieldable Drupal entities with concise dot-notation paths instead of verbose ->get()->value chains.

---

It wraps entities in a resolver backed by two plugin types (FluentFieldResolver and FluentFieldItemResolver) and the illuminate/collections library, so field, sub-field, and referenced-entity values can be pulled with a single fluent call. The FieldResolver walks the dot path (e.g. field_image.entity.field_media.uri) resolving each segment through the appropriate plugin, while FieldItemResolver handles the leaf field-item value extraction. Plugins are pluggable, so you can teach Fluent how to resolve custom field types. It exposes services fluent.service, fluent.field_resolver, and fluent.field_item_resolver plus their plugin managers. It has no routes, permissions, or UI — it is purely a coding aid for module and theme developers. A fluent_test submodule exists for its test suite.

---

- Read a nested entity-reference value with one dot-notation call.
- Avoid long chains of ->get(0)->value in custom code.
- Resolve an image field's file URI in a preprocess function.
- Traverse paragraph or media reference trees concisely.
- Write more readable field-access logic in controllers.
- Add a custom resolver plugin for a bespoke field type.
- Extract multiple field values into a collection for mapping.
- Simplify Twig-preprocess data preparation.
- Reduce boilerplate in entity-to-array transformations.
- Safely resolve deep paths that may be empty.
- Standardize field-value access patterns across a codebase.
- Speed up building JSON payloads from entities.
- Teach the resolver about a contrib field type via a plugin.
- Use Laravel-style collection helpers on resolved values.
- Improve readability of migration or export code.
- Prototype data access quickly during development.
