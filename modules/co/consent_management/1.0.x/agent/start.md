<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Consent Management — agent start

`consent_management` **1.0.1** — info.yml name **"Consent Management"**, description
*"Creates data policies and manages user consent."* Core `^9 || ^10 || ^11`. Depends on core
`block` and `path_alias`. Not covered by Drupal's security advisory policy.

A GDPR-style data-policy / consent-tracking module (a re-implementation of, and migration target for,
the contrib `data_policy` module). An admin defines **policies**, each policy has versioned **policy
versions** carrying the actual policy text, and the module records each **authenticated** user's
agree/not-agree/undecided decision per policy version. When a new required policy version appears, users
are re-prompted.

## Entities (all content entities, revisionable except user consent)

- **`cm_policy`** (`Entity/Policy.php`) — a policy. Fields: `label`, `status` (enabled), `description`
  (text_long), `policy_required` (bool), `user_roles` (multi entity_ref — limit policy to roles),
  `consent_formula` (text_long, default `I agree to [policy:link]`), `cm_policy_version` (ref to the
  current version), `source_id` (migration). Admin permission `administer cm_policy`. Collection at
  `/admin/config/people/cm-policy`.
- **`cm_policy_version`** (`Entity/PolicyVersion.php`) — a version of a policy. Fields: `label`,
  `status`, `policy_text` (text_long — the actual policy body), `cm_policy` (back-ref), `source_id`.
  Admin permission `administer cm_policy_version`. On save it writes its own id back onto the parent
  policy's `cm_policy_version`.
- **`cm_user_consent`** (`Entity/UserConsent.php`) — one consent record. Fields: `uid`, `cm_policy_version`,
  `state` (int: 0 undecided, 1 not-agreed, 2 agreed), `status` (published flag used to mark the "current"
  record), `created`/`changed`, and a **server-captured snapshot** of the user at consent time —
  `meta_user_id`, `meta_user_uuid`, `meta_user_name`, `meta_user_mail`, `meta_user_created`,
  `meta_user_cancelled`. The snapshot preserves who consented even if the user account is later deleted
  (`consent_management_user_predelete()` re-points `uid` to user 1 and stamps `meta_user_cancelled`).
  Collection route `/admin/reports/cm-user-consents`.

## How the prompt works (no block plugin despite the `block` dependency)

There is **no Block plugin**. Enforcement is a kernel `REQUEST` subscriber,
`EventSubscriber/RedirectSubscriber.php` (priority 28):

- Returns immediately for **anonymous** users, for the `bypass consent` permission, on the agreement
  route itself, and on a whitelist of system routes (403/404, batch, css/js, logout, user cancel, …).
- If active required policies exist and the user has not agreed, it redirects to **`/policy-agreement`**
  (`Form/PolicyAgreement.php`, route `consent_management.policy.agreement`), preserving the destination.
- New (non-required) versions instead add a status message linking to the agreement page.
- `hook_consent_management_destination_alter()` lets other modules override the post-consent destination.

`Form/PolicyAgreement.php` renders one checkbox per active policy version (`ConsentManager::addCheckbox`),
each labelled from the policy's `consent_formula` with the `[policy:link]` token replaced by an AJAX modal
link to the policy text. Submitting calls `ConsentManager::saveConsent()` which creates/unpublishes
`cm_user_consent` records. A required policy the user declines redirects to the account-cancel form (only
when core `data_policy.data_policy:enforce_consent` config is set).

## Public policy display

- Route **`/policy`** (`Controller/Policy::entityOverviewPage`) — renders a policy version's `policy_text`
  (looked up by `?id=<policy_version_id>`) via the field's own formatter, in a themed wrapper. Access =
  "any policy exists" (`entityOverviewAccess`), so it is reachable without a specific permission — it is
  the public agreement text shown in the consent modal.

## Routes & permissions

- `/admin/config/people/cm-policy/{cm_policy}/policy-versions` — versions list
  (`ConsentManagementPolicyVersionsController`), perm `access consent management policy versions`.
- `/admin/consent-management/migration` — `Form/MigrationForm.php`, perm `administer site configuration`;
  migrates data from the contrib `data_policy` module (only offered when `data_policy` is enabled).
- Permissions (`consent_management.permissions.yml`): per-entity CRUD + revision perms for `cm_policy`
  and `cm_policy_version` (with `administer …` marked *restrict access*), `access consent management
  policy versions`, `access consent management user report`, and **`bypass consent`** (skip enforcement).

## Views integration

Ships `config/install/views.view.consent_management_user_history_report.yml` — user consent report at
`/admin/reports/consent-management/history` gated by `access consent management user report`, with a `uid`
contextual filter defaulting to the `?user` query parameter. Provides views plugins: field handlers
`user_consent_state`, `current_policy_state`, `modal_dialog_policy_versions`; filter `consent_state_filter`
(`Plugin/views/filter/ConsentStateFilter.php`); and field formatters `state_text`, `modal_dialog_policy`.
README note: the consent state/history fields work on any user view without adding a relationship.

## Services, Drush, migration

- `consent_management.manager` (`ConsentManager`) — the consent read/write logic.
- `consent_management.helper` (`Helper`) — policy/version lookups, snapshot update on user delete.
- `consent_management.migration` (`Migration`) + `Src/Batch/*` + `Commands/BatchCommands.php` — Drush
  command `consent-management:migrate-user-consent` (aliases `comuc`, `migrate-user-consent`) and batch
  migration from the legacy `data_policy` module. `Plugin/QueueWorker/UserConsentPolicyVersionSync` syncs
  consent to new versions.

## Notes for agents

- Consent writes are **authenticated-only** and driven by the current user; the PII snapshot fields are
  filled server-side from the User entity, not from request input.
- Several revision methods in `Controller/Policy.php` (`revisionsOverviewPage`, `revisionOverviewPage`,
  `revisionEditAccess`) reference an undefined `$this->dataPolicyConsentManager` and the legacy
  `data_policy` storage — they are **dead code with no routes wired to them** (leftovers from the
  `data_policy` origin) and would fatal if ever invoked.
- Config schema is a stub (`consent_management.settings` with a single `example` string); the module has
  no active settings form (the migration-settings route is commented out).
