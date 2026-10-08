<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Confirmation messages (entity_confirmation)

All logic is in `entity_confirmation.module` (no routes/services/plugins). Schema:
`config/schema/entity_confirmation.schema.yml`. Alter contract: `entity_confirmation.api.php`.

## Install / enable

`composer require drupal/entity_confirmation`, then enable the module. No configuration form of its own — you
configure it on each entity type's **Manage form display** page (per form mode). Enable the **Token** module too if
you want a token tree link and token replacement in messages (optional).

## Where you configure it

`entity_confirmation_form_alter()` detects when the form being built is an entity form whose entity is an
`EntityFormDisplayInterface` (i.e. the *Manage form display* form) and that supports `getThirdPartySetting()`. It then
adds a `#type => 'details'` group `confirmation` ("Confirmation settings", grouped under `additional_settings`) with,
for each of **create / edit / delete**:

- a textarea `confirmation_<op>` — the custom message (blank = keep default),
- a checkbox `confirmation_<op>_disable` — hide the default message for that op.

`#states` disable the textarea when the matching disable box is checked. When `token` is enabled it also adds a
`token_tree_link` (`#token_types => [$entity->getTargetEntityTypeId()]`).

## How the settings are stored

The form registers `$form['#entity_builders'][] = 'entity_confirmation_form_entity_type_form_builder'`. That builder
(`entity_confirmation_form_entity_type_form_builder()`) writes the six values as **third-party settings** onto the
`EntityFormDisplay` config entity:

```
$type->setThirdPartySetting('entity_confirmation', $key, $form_state->getValue($key));
```

for `$key` in `confirmation_create`, `confirmation_create_disable`, `confirmation_edit`, `confirmation_edit_disable`,
`confirmation_delete`, `confirmation_delete_disable`.

Persisted in config `core.entity_form_display.<entity_type>.<bundle>.<form_mode>` under
`third_party_settings.entity_confirmation`. Schema type
`core.entity_form_display.*.*.*.third_party.entity_confirmation`: the three `confirmation_<op>` keys are `text`, the
three `confirmation_<op>_disable` keys are `boolean`.

## What happens on save

For every non-config entity form, `form_alter` appends `entity_confirmation_form_op_submit()` to the submit handlers.
On submit (skipping rebuilds via `$form_state->isRebuilding()`):

1. Gets the entity and the active `form_display` from `$form_state->get('form_display')`.
2. Normalizes the operation: `$op = $formObject->getOperation()`, mapping `default` → `create` (so `edit` and
   `delete` stay as-is).
3. If `confirmation_<op>_disable` is set on the form display → `\Drupal::messenger()->deleteByType('status')` (removes
   the default confirmation, shows nothing custom).
4. Else if `confirmation_<op>` has a value → deletes the default status messages, invokes
   `hook_entity_confirmation_alter($value, $op, $entity)` and the matching theme alter, then adds the message with
   `messenger()->addStatus(Markup::create(Xss::filterAdmin($token->replace($value, [$entity->getEntityTypeId() => $entity]))))`.

So token replacement runs first, the whole result is run through `Xss::filterAdmin()` (admin tag allow-list), and only
then marked safe. If neither disable nor a value is set, the core default message is left untouched.

## Extending

`hook_entity_confirmation_alter(string &$value, string $op, EntityInterface $entity)` (documented in
`entity_confirmation.api.php`) lets another module rewrite the message string before it is filtered and shown; a theme
alter of the same name is also invoked.

## Notes

- Delete confirmation applies to the entity delete **form** submit (the op is `delete`).
- Message text is entity-admin content, filtered with `Xss::filterAdmin()` — basic HTML (links, emphasis) survives,
  scripts/dangerous markup are stripped.
- The module only touches the `status` messenger channel; it does not alter redirects, warnings, or errors.
