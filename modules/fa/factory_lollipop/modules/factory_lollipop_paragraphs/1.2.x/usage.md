<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Factory Lollipop - Paragraphs is a submodule that adds `paragraph` and `paragraph type` FactoryTypes so Factory Lollipop can build valid Paragraphs entities and bundles in tests.

---

Enable this submodule (it requires the `factory_lollipop` parent and the contrib `paragraphs` module) to extend the Factory Lollipop type set with two more data types. `ParagraphTypeFactoryType` (`paragraph type`) creates or loads a `paragraphs_type` bundle, and `ParagraphFactoryType` (`paragraph`) creates a `paragraph` entity for an existing paragraph type. Both are registered as tagged services on the parent's `factory_lollipop.factory_type_resolver` collector at priority 245 and are used exactly like the built-in types: declare a blueprint with `FixtureFactory::define('paragraph type', ...)` / `define('paragraph', ...)` and instantiate it with `create()`. The submodule adds no routes, permissions, config or runtime behaviour; it is invoked only from test/CLI code through the parent's `FixtureFactory` service.

---

- Create a paragraph type (bundle) blueprint for use across a Paragraphs test suite.
- Create paragraph entities of an existing paragraph type inside a kernel test.
- Cascade a paragraph's `type` from a paragraph-type factory via `FixtureFactory::association()`.
- Attach factory-built paragraphs to an entity-reference-revisions field for content tests.
- Test custom Paragraphs behaviour (fields, widgets, rendering) against generated paragraph data.
- Build coherent layout scenarios (paragraph types + paragraphs) without config sync or fixtures.
- Override or decorate the paragraph/paragraph-type creation logic with a higher-priority tagged service.
- Reuse the parent module's random-data traits when defining paragraph blueprints.
- Generate paragraph types with random machine names/labels when none are supplied.
- Seed sample Paragraphs content from a Drush/PHP script on a dev site.
- Combine paragraph factories with node/media/field factories for full-page test fixtures.
- Register paragraph blueprints as `FactoryInterface` classes and bulk-load them with `loadAllDefinitions()`.
