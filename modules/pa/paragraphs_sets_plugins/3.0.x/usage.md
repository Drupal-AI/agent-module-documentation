<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Paragraphs Sets Plugins extends the Paragraphs Sets module with a pluggable "process" system: when a Paragraphs Set is applied, its predefined source data is run through transform plugins that can create entities, build nested entities, or map values before the resulting paragraphs are inserted. This lets set definitions do more than static prefills.

---

It defines a `ParagraphsSetsProcess` annotation and a plugin manager (`PluginManager`, service `paragraphs_sets_plugins.plugin_manager`) that discovers process plugins under `Plugin/paragraphs_sets/process` (base `ProcessPluginBase` / `ProcessPluginInterface`), shipping three: `Simple` (straight mapping), `CreateEntity`, and `NestedEntities`. The `PluginTransformProcessor` (service `paragraphs_sets_plugins.plugin_transform_processor`) walks the set data recursively; `hook_paragraphs_set_data_alter()` hands each set's data to that processor so plugins can transform it in place. It depends on `paragraphs_sets`, defines no permissions or admin UI, and is primarily a developer/site-builder extension point rather than an end-user feature.

---

- Auto-create referenced entities when a Paragraphs Set is applied.
- Build nested entity structures from a single set definition.
- Map/transform a set's source data before paragraphs are generated.
- Prefill complex paragraph structures beyond static defaults.
- Add custom transform logic by writing a `@ParagraphsSetsProcess` plugin.
- Reuse the `Simple` plugin for straightforward value mapping.
- Use `CreateEntity` to instantiate related content as part of a set.
- Use `NestedEntities` to populate multi-level paragraph/entity trees.
- Process set data recursively via the transform processor service.
- Keep set-application logic in plugins instead of ad-hoc hooks.
- Give editors richer, pre-populated paragraph sets to start from.
- Standardize how repeated content blocks are scaffolded.
- Extend Paragraphs Sets without patching the base module.
- Drive entity creation declaratively from set definitions.
- Share process plugins across projects as reusable code.
- Reduce manual paragraph setup for common layout patterns.
