<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Bundle Scaffold (entity_bundle_scaffold) — agent index
**Drush commands + services to scaffold entity types/bundles and generate bundle classes & wmcontroller controllers.**

- **Version:** 3.1.x
- **Core:** ^10.0 || ^11.0 · **PHP:** 7.4+
- **Drush:** `nodetype:create`, `vocabulary:create`, `paragraphs:type:create`, `eck:type:create`, `eck:bundle:create`, `eck:bundle:delete`, `entity:bundle-class-generate`, `wmcontroller:generate`.
- **Services:** php-parser factories/pretty-printer, `entity_bundle_class_generator`, `controller_class_generator`, plugin manager `plugin.manager.entity_bundle_class_method_generator`.
- **Plugin type:** `EntityBundleClassMethodGenerator` (per field type); alter hook `hook_entity_bundle_class_method_generator_alter()`.
- **Config:** `entity_bundle_scaffold.settings` (namespaces, base classes, output module, auto_create/auto_update).
- **Hook:** `hook_entity_insert()` regenerates classes/controllers for field-config/bundle inserts (skips config sync).

**Security:** Development/CLI tool — no routes, permissions, or web endpoints. Generates PHP files on disk from local entity definitions (not from request input). No security findings.
See [drush/commands.md](drush/commands.md)
