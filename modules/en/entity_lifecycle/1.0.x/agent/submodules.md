<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bundled submodules

All ship in `modules/` of the project, share `version 1.0.0-beta3` and `core_version_requirement
^10.3 || ^11`, and depend on `entity_lifecycle`. Each mainly registers extra `LifecycleCondition`
plugins or wiring; none is documented in its own tree here.

## entity_lifecycle_user

Adds lifecycle tracking for **user accounts** (a bundleless type). Registers `user` via
`hook_entity_lifecycle_bundleless_entity_types()`, excludes the anonymous user from queries/stats/summary,
adds the five lifecycle base fields to `user` (all non-translatable), and adds lifecycle config to the
People account-settings form and the user edit form (status gated on `administer user lifecycle`; override
fields on that permission + `allow_override`). Permission `administer user lifecycle` (restrict access).
View `user_lifecycle_review` at `admin/people/lifecycle-review` (access `administer user lifecycle`).
Condition plugins (all `entity_types = {"user"}`, category `user`): `last_login` (not logged in for N
months), `account_age` (account older than N months), `account_status` (active vs. blocked). It also
excludes the core `age` condition from users via
`hook_entity_lifecycle_condition_excluded_entity_types()`. Files: `entity_lifecycle_user.module`,
`src/Form/UserLifecycleSettingsForm.php`, `src/Plugin/LifecycleCondition/*`.

## entity_lifecycle_entity_usage

Depends on `entity_usage`. Adds the `entity_usage` condition plugin
(`src/Plugin/LifecycleCondition/EntityUsageCondition.php`, category `usage`, weight 25) — evaluates how
many times an entity is referenced by other content (e.g. flag unused content for archival).

## entity_lifecycle_linkchecker

Depends on `linkchecker`. Adds the `broken_links` condition plugin
(`src/Plugin/LifecycleCondition/BrokenLinksCondition.php`, category `content`, weight 20) — matches
content that contains broken links (HTTP errors), read from linkchecker's tables.

## entity_lifecycle_radioactivity

Depends on `radioactivity`. Adds the `radioactivity` condition plugin
(`src/Plugin/LifecycleCondition/RadioactivityCondition.php`, category `content`, weight 10) — matches
content whose Radioactivity energy (popularity/engagement) is low.

## entity_lifecycle_eca

Depends on `eca`, `eca_base`. Bridges lifecycle status changes to the ECA (Event-Condition-Action) engine
for workflow automation such as email notifications. Service
`entity_lifecycle_eca.event_dispatcher` = `LifecycleEventDispatcher` (an `EventSubscriberInterface` used
as a dispatcher). The parent module calls it from `_entity_lifecycle_dispatch_status_event()` /
`_dispatch_scan_event()` (guarded by `moduleExists('entity_lifecycle_eca')`).

- Event constants in `EntityLifecycleEvents`: `status_changed`, `status_to_needs_review`,
  `status_to_outdated`, `status_to_current`, `scan_completed`, `batch_status_changed`, `entity_reviewed`,
  `review_overdue`.
- Event objects in `src/Event/`: `LifecycleStatusChangedEvent`, `LifecycleScanCompletedEvent`,
  `LifecycleReviewEvent`.
- ECA event plugin `LifecycleEvent` (`@EcaEvent(id="entity_lifecycle")` + `LifecycleEventDeriver`) exposes
  these events (and tokens like entity, old_status, new_status, changed_by, matched_conditions, author) to
  the ECA UI.
- Ships example workflows in `config/optional/eca.eca.*` (content-reviewed, needs-review email,
  outdated-urgent email, scan digest).
