<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
An example/developer submodule of Content Sync that ships a sample custom field type (`cs_custom_field`) plus example entity- and field-handler plugins showing how to teach Content Sync to serialize a bespoke field or entity during sync.

---

This submodule is reference code, not a feature you deploy to production. It defines a small custom field type `cs_custom_field` (with its own FieldType, FieldWidget and FieldFormatter) purely so it has something to demonstrate against, and then provides three Content Sync plugins: `CustomFieldHandler` (`@FieldHandler id=cms_content_sync_custom_field_handler`) which `supports()` the `cs_custom_field` type and extends `DefaultFieldHandler`; `IgnoreFieldHandler` (`@FieldHandler id=cms_content_sync_ignore_field_handler`) which matches a field named `field_ignore_example` and returns TRUE without pushing/pulling any data (i.e. excludes a field from sync); and `CustomTaxonomyHandler` (`@EntityHandler id=cms_content_sync_custom_taxonomy_handler`) extending `DefaultTaxonomyHandler`. Together they are the canonical worked example for the two plugin types documented in the parent module's `plugins/handlers.md`. Enable it only to study or copy the pattern; the field type and handlers have no configuration UI of their own.

---

- Learn how to register a Content Sync `@FieldHandler` plugin for a custom field type.
- Copy `CustomFieldHandler` as a starting point for serializing your own field type during sync.
- See how a handler's `static supports()` method decides which fields it applies to.
- Understand how to exclude a specific field from syndication with an ignore-style handler.
- Study `IgnoreFieldHandler` to skip a field (e.g. a local-only field) during push/pull.
- Learn how to register a Content Sync `@EntityHandler` by extending `DefaultTaxonomyHandler`.
- Reference `CustomTaxonomyHandler` when writing a bespoke entity handler for a vocabulary.
- Provide a sample `cs_custom_field` field type to test Content Sync handler behavior end to end.
- Inspect a minimal FieldType/FieldWidget/FieldFormatter trio alongside their sync handler.
- Teach developers where handler plugins live (`src/Plugin/cms_content_sync/{entity_handler,field_handler}`).
- Use as a template for a module that adds sync support for a contrib field type.
- Demonstrate the handler `weight` property used to pick between competing handlers.
- Show how a field handler can fall back to `parent::push()` for default behavior.
- Validate a local Content Sync setup by adding the example field to a content type.
- Serve as fixture code in a training or onboarding session on Content Sync internals.
- Prototype a new field handler against a throwaway field type before applying it to a real one.
- Confirm the plugin discovery directory and annotation names by reading working example code.
- Base a custom media or file handler on the same extend-the-default pattern.
- Test that Content Sync correctly ignores fields your handler returns TRUE-without-data for.
- Illustrate the difference between an entity handler and a field handler in one module.
