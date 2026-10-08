<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Bundle Scaffold — Drush commands

Run with `-h` for full arguments/options.

## Structure creation
- `nodetype:create` (aliases `ntc`) — create a node type.
- `vocabulary:create` (`vc`) — create a taxonomy vocabulary.
- `paragraphs:type:create` (`ptc`) — create a Paragraphs type (needs paragraphs).
- `eck:type:create` (`etc`) — create an eck entity type (needs eck).
- `eck:bundle:create` (`ebc`) / `eck:bundle:delete` (`ebd`) — manage eck bundles.

## Code generation
- `entity:bundle-class-generate` (`ebcg`) — generate an entity bundle class with typed field getters.
- `wmcontroller:generate` (`wmcg`) — generate a wmcontroller controller with a `show` method (needs wmcontroller).

## Post-command hooks
- After `nodetype:create` / `vocabulary:create`, generators can run automatically depending on `auto_create`.

## Config that drives generation (`entity_bundle_scaffold.settings`)
- `generators.bundle_class`: `base_classes`, `fields_to_ignore`, `output_module`, `field_getter_name_source`, `namespace_pattern`, `auto_create`, `auto_update`.
- `generators.controller`: `base_class`, `output_module`, `namespace_pattern`, `auto_create`.

## Extending
- Add an `EntityBundleClassMethodGenerator` plugin to control how a field type's getter is generated.
- Use `hook_entity_bundle_class_method_generator_alter()` to swap a generator class.
