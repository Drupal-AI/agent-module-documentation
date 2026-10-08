<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auto-generate configuration & behavior

## Enable

`drush en association_autogen` (requires `association`). No install hook, no permissions.

## Where config lives

Rules are **third-party settings** on the `association_type` config entity under key
`association_autogen`, schema `association.type.*.third_party.association_autogen`
(`config/schema/association.autogen.schema.yml`):

```yaml
association_autogen:
  generate:
    - tag: 'node:page'            # a behavior tag on the type
      entityBundle: 'node:page'   # entity_type:bundle to create
      active: true                # published state of the created entity
      label:
        pattern: '[association:name]: page'   # token pattern for the label
        allowEdit: false          # if false, member label field is locked
```

Edit via `Form/AssociationAutogenSettingsForm` at
`/admin/structure/association/manage/{association_type}/autogen` (local action "Edit … auto-generation
settings"; access `_entity_access: association_type.edit`). The form's Add/Remove buttons are AJAX and
respect the behavior's per-tag `cardinality` (only tags with remaining capacity are offered; validation
re-checks the limit). A `token_tree_link` for `association` / `node_type` token types is shown.

## Runtime flow

1. `association_autogen_association_insert($association)` fires after a new association is saved.
2. `EntityGenerator::generateMultiple()` loops the `generate` rules. For each: split `entityBundle`
   into `entity_type:bundle`, verify `behavior->isValidEntity(tag,type,bundle)`, then:
   - resolve label = `Token::replace(label.pattern, ['association' => $association])` (falls back to
     `[association:name]: <bundle>`),
   - `behavior->createEntity(...)`, set published from `active` (or the entity's `status` key),
   - `save()`, then `associateEntity(tag, entity, FALSE)` and save the link with `link->autogen = ruleId`.
3. Per-rule failures (missing adapter/type/field) are logged to channel `association_autogen` and
   skipped; storage errors also surface a user message.

## Label locking

`AssociatedEntitySubscriber::onAssociatedFormAlter` (events `INSERT/UPDATE_ASSOCIATED_FORM_ALTER`,
priority 30) finds the member's `association_link`, reads its `autogen` rule, and if
`label.allowEdit` is empty force-sets `#value` and `#disabled = TRUE` on the label widget so the
generated title can't be changed on later edits.

## Notes

- The `autogen` read-only string field (max 36, ASCII) on `association_link` records which rule created
  a link. Generation and settings are entirely admin-gated (association-type edit access); token
  replacement uses the standard Token API (escaped), and created entities go through the behavior's
  normal `createEntity` allow-list.
