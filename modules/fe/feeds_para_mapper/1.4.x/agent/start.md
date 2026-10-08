<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# feeds_para_mapper — agent start

**Feeds add-on, no runtime surface of its own.** `configure = null`; no permissions, Drush,
config, or config entities. Enabling it exposes nothing on its own — it only adds behavior to
the **Feeds mapping UI**. Requires `feeds` (^3.0) + `paragraphs` (which supplies
`entity_reference_revisions`).

What it does: when a Feed Type's processor targets an entity with a Paragraphs field, it
surfaces each supported **leaf field inside the referenced paragraph bundles** (nested +
multi-valued included) as its own mapping target, and imports incoming values into
Paragraphs entities it creates/updates for you. It removes the raw `paragraphs` target so
you map to sub-fields instead.

- Operator workflow — set up a Feed Type that maps to paragraph sub-fields, the auto-removed
  `paragraphs` target + refresh warning, the per-mapping **Maximum Values** setting, nested /
  multi-valued behavior, updates & revisions, Feeds Tamper → [configure/mapping.md](configure/mapping.md)
- Architecture & code — the `wrapper_target` FeedsTarget plugin, the `Mapper` / `Importer` /
  `RevisionHandler` services, the `target_info` path model, and the two hooks it implements →
  [api/services.md](api/services.md)

Key names: FeedsTarget plugin `wrapper_target`
(`Drupal\feeds_para_mapper\Feeds\Target\WrapperTarget`, `field_types: entity_reference_revisions`);
services `feeds_para_mapper.mapper`, `feeds_para_mapper.importer`,
`feeds_para_mapper.revision_handler`; per-field state object
`Drupal\feeds_para_mapper\Utility\TargetInfo` (carried on the FieldConfig as `target_info`);
hooks implemented: `hook_feeds_targets_alter`, `hook_entity_update`, `hook_help`. No `*.api.php`
(the module invites no hooks of its own).
