# Field access hook

`view_user_email.module` implements `hook_entity_field_access()` as
`view_user_email_entity_field_access($operation, $field_definition, $account, $items)`.

Behavior:

1. If the field machine name is not `mail`, OR the operation is not `view`, return
   `AccessResult::neutral()` (the module abstains).
2. Else if `$account->hasPermission('access email field')`, return `AccessResult::allowed()`.
3. Else return `AccessResult::neutral()`.

## What this means

- The module only ever GRANTS (`allowed`) or abstains (`neutral`); it never returns
  `forbidden`, so it cannot revoke access another handler grants.
- Drupal combines all field-access results: access is granted when at least one handler returns
  `allowed` and none returns `forbidden`. Core's user access handler returns `neutral` (not
  `forbidden`) for the `mail` field when the account lacks `administer users`, so this module's
  `allowed()` is what tips the result for permission holders.
- Because it hooks the entity field-access layer, the grant applies everywhere field access is
  checked: the user profile view, entity and Views field rendering, and REST / JSON:API
  serialization.

## Scope note

The condition matches any field named `mail` on any entity type — it does not restrict to the
`user` entity. On a standard site only the user entity carries a `mail` field, so in practice
the effect is user email only; keep it in mind if you add a `mail` field to another entity type.

## Displaying the field

Field access is necessary but not sufficient for the address to appear: the `mail` field must
also be placed on the relevant display (user view display, a field in a View, or included in the
REST/JSON:API output). The module handles access only; you still configure where the field shows.
