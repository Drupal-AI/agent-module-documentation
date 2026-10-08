<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Association Entity Auto-generate (association_autogen) — agent index

Submodule of **[Entity Association](../../../../2.0.x/agent/start.md)** (depends on `association`).
Auto-creates and links member entities when a new `association` is inserted. Version 2.0.0-alpha9,
core `^10.2 || ^11`, package *Content Building*.

## What it provides (from source)

- **Trigger**: `association_autogen_association_insert` (`association_autogen.module`) — on association
  insert, reads the type's `association_autogen` third-party settings and calls
  `EntityGenerator::generateMultiple($association, $autogen)` (service `association.autogen.generator`,
  class `src/Utility/EntityGenerator.php`).
- **Generation** (`EntityGenerator`): for each rule `{ tag, entityBundle, active, label{pattern,allowEdit} }`
  it validates the tag via the behavior, builds the label with `Token::replace($pattern, ['association' => $association])`,
  calls `behavior->createEntity()`, sets published from `active`, saves, then `associateEntity()` and
  saves the `association_link` with `$link->autogen = <ruleId>`. Errors are logged per-rule and skipped.
- **Extra base field**: `hook_entity_base_field_info` adds the read-only `autogen` string field to
  `association_link` (stores the rule id that created the link).
- **Form-lock**: `EventSubscriber/AssociatedEntitySubscriber` listens to
  `INSERT/UPDATE_ASSOCIATED_FORM_ALTER`; when the matching rule has `allowEdit = false` it force-sets
  and disables the member's label widget.
- **Settings form**: `Form/AssociationAutogenSettingsForm` at route
  `entity.association_type.autogen` → `/admin/structure/association/manage/{association_type}/autogen`
  (`_entity_access: association_type.edit`). AJAX add/remove rules; enforces behavior tag cardinality.
- **Config schema**: `config/schema/association.autogen.schema.yml` —
  `association.type.*.third_party.association_autogen` with a `generate` sequence of
  `{ tag, label{pattern,allowEdit}, active, entityBundle }`.

No permissions, services beyond the generator, routes beyond the settings form, or plugin types of its
own. Details: [config/autogen.md](config/autogen.md).
