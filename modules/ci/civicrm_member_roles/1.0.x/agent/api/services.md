# Services / API

## `civicrm_member_roles` — `CivicrmMemberRoles`

The sync + CiviCRM-lookup utility. Constructor args: `@civicrm`, `@config.factory`,
`@entity_type.manager`, `@database`. Reads config `civicrm_member_roles.settings`.
Get it with `\Drupal::service('civicrm_member_roles')`.

| Method | Signature | Purpose |
|--------|-----------|---------|
| `sync` | `sync($limit = NULL)` | Sync every contact from `getSyncContactIds($limit)`. |
| `getSyncContactIds` | `getSyncContactIds($limit = NULL): array` | Contact ids that hold a membership of a type used by any rule. Uses Api4 `UFMatch` joined to `Membership`, filtered `membership_type_id IN <rule types>`, with `LIMIT`. |
| `syncUser` | `syncUser(AccountInterface $account)` | Resolve the account's contact (via `UFMatch` `uf_id`) and sync it. |
| `syncContact` | `syncContact($cid, AccountInterface $account)` | Core logic: add/remove rule-managed roles from the account per the contact's memberships. Saves the user only if roles changed. |
| `getUserContactId` | `getUserContactId(AccountInterface $account): int\|null` | CiviCRM contact id for a Drupal account, or NULL. |
| `getContactAccount` | `getContactAccount($cid): AccountInterface\|null` | Drupal user linked to a contact id, or NULL. |
| `getTypes` | `getTypes(): array` | Membership types, `id => name` (via `civicrm_api3 MembershipType get`). |
| `getType` | `getType($id): array\|null` | Single membership type, or NULL. |
| `getStatuses` | `getStatuses(): array` | Membership statuses, `id => name` (via `civicrm_api3 MembershipStatus get`). |

Protected helpers of note: `getRules()` loads all `civicrm_member_role_rule` entities;
`getAddRoles()` / `getExpiredRoles()` collect roles per membership status; `getInactiveStatusIds()`
resolves the ids of statuses named `Deceased`, `Cancelled`, `Pending`, `Expired`.

### Example

```php
/** @var \Drupal\civicrm_member_roles\CivicrmMemberRoles $svc */
$svc = \Drupal::service('civicrm_member_roles');

// Sync one Drupal user's roles from their CiviCRM membership.
$svc->syncUser($account);

// Sync one CiviCRM contact.
if ($account = $svc->getContactAccount($contactId)) {
  $svc->syncContact($contactId, $account);
}

// Sync everyone (respect a limit if you like).
$svc->sync(150);
```

`syncContact` behavior summary: drops inactive memberships when a contact has several (unless the
inactive status is a rule `current` status); with no memberships it strips all rule roles; otherwise
it removes roles for `expired`-listed statuses and adds roles for `current`-listed statuses. See
[configure/rules.md](../configure/rules.md).

## `civicrm_member_roles.batch.sync` — `Batch\Sync`

Wraps a full sync as a Batch API job. Constructor args: `@string_translation`,
`@civicrm_member_roles`, `@messenger`.

- `getBatch(): array` — returns a batch whose single operation is `process()`.
- `process(&$context)` — seeds `getSyncContactIds()` into the sandbox and syncs one contact per
  iteration, reporting progress.
- `finished($success, $results)` — messages the count of users processed.

Used by the Manual Synchronize form and by the Drush command's no-argument path.
