<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field: `preserve_changed_time` and the save mechanism

## The base field

`preserve_changed_ui_entity_base_field_info()` (`hook_entity_base_field_info`) adds one base field,
but ONLY to the `node` entity type (the `if ($entity_type->id() === 'node')` guard):

| Property | Value |
| --- | --- |
| Machine name | `preserve_changed_time` |
| Type | `boolean` (`BaseFieldDefinition::create('boolean')`) |
| Label | "Preserve changed time" |
| Description | "Prevents updating the 'Last saved'-date on save, instead keeps the last change date. Typically used for minor changes like typo fixes." |
| Form display | configurable (`setDisplayConfigurable('form', TRUE)`) |
| View display | not configurable (`setDisplayConfigurable('view', FALSE)`) |
| Translatable | `FALSE` |
| Revisionable | `FALSE` |

Because it is a base field, it exists on every node bundle, but it is NOT shown on the form by
default. Enable its widget per bundle at `/admin/structure/types/manage/<type>/form-display`
(drag "Preserve changed time" out of "Disabled"). Until it is placed there,
`hook_form_node_form_alter` sees no `$form['preserve_changed_time']` and does nothing.

After adding/removing the base field, run `drush entity-updates` / `drush updatedb` (or
`drush cr` on newer core) so the storage definition is applied.

## On the node form

`preserve_changed_ui_form_node_form_alter()` (`hook_form_node_form_alter`):

- Returns early if `$form['preserve_changed_time']` is not present (field not enabled on the display).
- For a NEW node (`$entity->isNew()`) OR a user lacking permission
  `preserve_changed_ui allow preserve changed time`: sets
  `$form['preserve_changed_time']['#access'] = FALSE` and forces the widget default to `FALSE`
  (the checkbox is hidden and cannot be submitted).
- Otherwise sets the checkbox `#default_value` from config
  `preserve_changed_ui.settings:enable_preserve_changed_time`.

## On save (how the timestamp is preserved)

`preserve_changed_ui_entity_presave()` (`hook_entity_presave`), for a `ContentEntityInterface` whose
entity type id is `node`:

```php
if ($entity->hasField('preserve_changed_time')
    && isset($entity->preserve_changed_time)
    && !empty($entity->preserve_changed_time->value)) {
  $originalEntity = $entity->original;
  $entity->setChangedTime($originalEntity->getChangedTime());
  // Clear so the flag is not reused on a later save.
  $entity->set('preserve_changed_time', FALSE, FALSE);
}
```

When the box is checked, the node's `changed` value is reset to the ORIGINAL entity's changed time
(`$entity->original` = the pre-save loaded version), so the save does not advance "Last saved". The
flag is then cleared to `FALSE` (with `$notify = FALSE`), so it does not persist — each save is an
explicit, one-shot choice. Because the field is non-revisionable and cleared on presave, it is never
stored as `TRUE`.

Note: the presave hook itself does not re-check the permission; the checkbox is gated only in the
form alter. It fires for any node save where the field carries a truthy value (e.g. programmatic
saves that set `preserve_changed_time`), which is the module's intended one-shot toggle behavior.
