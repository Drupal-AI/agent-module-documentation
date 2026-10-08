<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CRM Core User Synchronization (crm_core_user_sync) — agent index

Pairs Drupal `user` accounts with `crm_core_individual` contacts through the
`crm_core_user_sync_relation` content entity, driven by role→contact-type rules and user
lifecycle hooks. Part of the CRM Core suite. Core `^9 || ^10 || ^11`, GPL-2.0-or-later.
Depends on `crm_core_contact`. `configure` route `crm_core_user_sync.config`.

## Entity

- **`crm_core_user_sync_relation`** (`src/Entity/Relation.php`) — content entity, base table
  `crm_core_user_sync_relation` (+ data table). `admin_permission = "administer crm-core-user-sync"`.
  Base fields `user_id` (ref → `user`) and `individual_id` (ref → `crm_core_individual`), both
  required, cardinality 1, each carrying the **`UniqueReference`** constraint (one link per side).
  Admin routes under `/admin/config/crm-core/user-sync/relation`.

## Services (`crm_core_user_sync.services.yml`)

- `crm_core_user_sync.relation` = `CrmCoreUserSyncRelation` — the workhorse: `relate()`,
  `getIndividualIdFromUserId()`, `getUserIdFromIndividualId()`, `getRelationIdFrom…()` (all queries
  use `accessCheck(TRUE)`).
- `crm_core_user_sync.relation_rules` = `CrmCoreUserSyncRelationRules` — resolves a contact type
  from the account's roles and validates a candidate relation against the configured rules.
- `crm_core_user_sync.request.event_subscriber` = `EventSubscriber\RequestSubscriber` — on each
  authenticated request, if `contact_load` is on, attaches the related Individual to
  `$account->crm_core['contact']`.
- `logger.channel.crm_core_user_sync`.

## Lifecycle hooks (`crm_core_user_sync.module`)

- `hook_user_insert` → auto-create+relate a contact when `auto_sync_user_create`.
- `hook_user_update` → ensure a related contact exists (auto-create if missing).
- `hook_user_delete` / `hook_crm_core_individual_delete` → delete the relation.
- `hook_entity_extra_field_info` + `hook_user_view` → optional "Contact information" on the user
  profile (`contact_show`).
- `hook_views_data_alter` → relationships/fields linking users and individuals to the relation.

## Routes / permissions (`crm_core_user_sync.routing.yml`, `.permissions.yml`)

- `/admin/config/crm-core/user-sync` — `Form\SettingsForm` (perm `administer crm-core-user-sync`).
- Rule routes `…/new`, `…/{rule_key}/edit`, `…/{rule_key}/delete`, `…/{rule_key}/enable`,
  `…/{rule_key}/disable` (all perm `administer crm-core-user-sync`; enable/disable go through
  `Controller\RuleStatusController`).
- Permissions: `administer crm-core-user-sync`, `edit own contact information`.

## Other plugins

- Block `crm_core_user_sync_edit_own_contact_information` (`Plugin/Block/…`) — renders the current
  user's linked Individual edit form; `blockAccess` = perm `edit own contact information`.
- Validation constraint `UniqueReference` (+ validator).
- Migrate process `RelationLookup`; Views field/query plugins `Plugin/views/{field,query}/Relation`.
- Batch helper `UserSyncBatch`.

## Solution docs

- **Settings, rules, relate() logic, the relation entity and self-service block** →
  [config-and-sync.md](config-and-sync.md)
