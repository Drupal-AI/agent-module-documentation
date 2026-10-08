<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Bundle Scaffold gives developers Drush commands and Drupal services to create entity types/bundles and to generate entity bundle classes and wmcontroller controllers.
---
The module removes the repetitive click-through work of defining content structures and hand-writing bundle classes. It ships Drush commands to create node types, vocabularies, paragraph types, and eck entity types/bundles, plus generators that build entity bundle class files (with typed field getters) and controller classes for the wmcontroller pattern. Generation is powered by nikic/php-parser (wired as services: parser factory, builder factory, pretty printer) and a pluggable `EntityBundleClassMethodGenerator` plugin type, with implementations for all the common field types (string, integer, datetime, entity reference, link, address, office hours, list/enum, computed, etc.). Behavior — namespaces, base classes, output module, whether to auto-create/auto-update on bundle changes — is driven by `entity_bundle_scaffold.settings`.

It can also react to configuration: `hook_entity_insert()` calls `EntityInsertHooks` when a field config or bundle is created, so bundle classes/controllers can be regenerated automatically when `auto_create`/`auto_update` are enabled (skipped during config sync). This is a development-time tool: it exposes no routes, permissions, or web-facing endpoints, and writes generated PHP files into the configured module's source tree.

Typical setup: `composer require` and enable it, adjust `entity_bundle_scaffold.settings` (output module, namespace pattern, base classes), then run the Drush commands or let the insert hook regenerate classes.
---
- Create a node type from the command line (`nodetype:create`).
- Create a taxonomy vocabulary via Drush (`vocabulary:create`).
- Create a Paragraphs type via Drush (`paragraphs:type:create`).
- Create an eck entity type (`eck:type:create`).
- Create/delete an eck bundle (`eck:bundle:create`, `eck:bundle:delete`).
- Generate an entity bundle class with typed field getters (`entity:bundle-class-generate`).
- Generate a wmcontroller controller with a `show` method (`wmcontroller:generate`).
- Auto-generate bundle classes when a bundle is created (auto_create).
- Auto-update bundle classes when a field is added (auto_update).
- Customize the generated namespace via a namespace pattern.
- Set base classes for generated bundle classes.
- Choose which module receives generated files (output_module).
- Ignore specific fields when generating getters.
- Choose field getter naming source (field name vs. label).
- Extend field-getter generation with custom `EntityBundleClassMethodGenerator` plugins.
- Alter generator plugin definitions via `hook_entity_bundle_class_method_generator_alter()`.
- Generate getters for address, office hours, link, datetime, enum, and computed fields.
- Normalize/pretty-print generated PHP with php-parser.
- Speed up scaffolding of repetitive entity structures in code review-friendly files.
- Integrate with wmmodel/entity_model plugin managers when present.
- Script entity-structure creation as part of a site build.
