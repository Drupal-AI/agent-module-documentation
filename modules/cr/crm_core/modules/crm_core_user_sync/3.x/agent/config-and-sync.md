<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User sync — settings, rules & the relate() flow

## Config object `crm_core_user_sync.settings`

Schema `config/schema/crm_core_user_sync.schema.yml`; install defaults all off:

| Key | Type | Meaning |
|-----|------|---------|
| `rules` | sequence of `crm_core_user_sync.rule` | role→contact-type mappings. |
| `auto_sync_user_create` | bool | Create a contact on user insert/update. |
| `auto_sync_user_relate` | bool | Link a new user to an existing contact by matching email. |
| `contact_load` | bool | Attach the related contact to the current user each request. |
| `contact_show` | bool | Show related contact info on the user profile. |

Each **rule** = `{role, contact_type, enabled, weight}`. Managed via `Form\SettingsForm`
(`/admin/config/crm-core/user-sync`) and per-rule forms `RuleForm` / `RuleDeleteConfirmForm`.
`Controller\RuleStatusController::enable()/disable()` flips `rules[$rule_key]['enabled']` and
redirects back to the settings page; both are gated by `administer crm-core-user-sync`.

## `CrmCoreUserSyncRelationRules` (`src/CrmCoreUserSyncRelationRules.php`)

Reads the `rules` config, orders by weight, and returns the `contact_type` for the account's roles
(`getContactType()`), plus `valid()` to confirm a user/individual pair may be related. Bound to
config name `crm_core_user_sync.settings`.

## `CrmCoreUserSyncRelation::relate(UserInterface, ?IndividualInterface)`

The central sync method (`src/CrmCoreUserSyncRelation.php`):

1. Skip if no individual given **and** `$account->crm_core_no_auto_sync` is set.
2. If no individual: bail if the account already has one; else resolve `contact_type` via the rules
   service (bail if none).
3. If `auto_sync_user_relate` and the type has a primary `email` field, try
   `loadByProperties([emailField => $account->getEmail(), 'type' => $contact_type])`; use it only on
   an **exact single** match.
4. Otherwise create a new Individual (owner = current user, `name.given` = account name, email set
   from the account when a primary email field exists) and save.
5. Re-validate with `rules->valid()`, ensure neither endpoint is already linked, then create and
   save a `Relation` and log a notice.

Lifecycle hooks in `crm_core_user_sync.module` call `relate()` (insert/update) or delete the
relation (user/individual delete).

## Relation entity

`crm_core_user_sync_relation` — see start.md. `user_id` and `individual_id` are required single
entity references, each with the custom **`UniqueReference`** constraint
(`Plugin/Validation/Constraint/UniqueReferenceConstraint(+Validator)`) enforcing one relation per
user and per individual. `label()` returns "Relation {id}". Getters/setters for both endpoints.

## Request subscriber

`EventSubscriber\RequestSubscriber::onKernelRequest()` — for authenticated users, when
`contact_load` is on, loads the related Individual and stores it at
`$account->crm_core['contact']` on the current user object (a convenience for other code/tokens; it
does not change access).

## Self-service block

`Plugin/Block/EditOwnContactInformationBlock` (id
`crm_core_user_sync_edit_own_contact_information`, category "CRM Core") — `blockAccess` requires
`edit own contact information`; `build()` loads the current user's linked Individual and renders its
default edit form (with the delete action removed). Place it on a page where signed-in users manage
their own contact record.

## Optional Views & migration

`config/optional/views.view.user_to_contact_management.yml` and
`…contact_to_user_management.yml` provide admin management screens (perm
`administer crm-core-user-sync`). `Plugin/migrate/process/RelationLookup` and `UserSyncBatch`
support migrating/bulk-relating existing data.
