<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Guard enforces fail-closed per-field access, denying with an unoverridable forbidden(), with an opt-in own-subject view exemption.

---

Field Guard provides config-driven per-field access control that fails closed: when a field is guarded, it denies access with `AccessResult::forbidden()` via `hook_entity_field_access()` — a result that no permission, `is_admin` role, or even user 1 can override, because `EntityAccessControlHandler::fieldAccess()` folds hook results with `orIf()` and contains no admin bypass. Enforcement is through Drupal's authoritative field-access system, so it applies wherever core calls it — entity form, entity view, REST, and JSON:API. It defines no permissions of its own: you nominate any permission your site already provides, and access is granted only when a non-admin role explicitly names that permission in its own configuration (the check deliberately avoids `hasPermission()`, which grants everything to admins and uid 1). This makes each grant a reviewable line in a config diff.

The map is `protected.<entity_type>.<bundle>.<field_name>.<operation>` → permission, edited in config and applied with `drush config:import`; it ships empty, so enabling the module changes nothing until you configure it. Only `view` and `edit` operations are honoured; an omitted operation and an empty permission string are both treated as unset. Definition-level checks (JSON:API/Views asking whether a field may be filtered or sorted on, with no entity in scope) also fail closed, so guarded fields become unfilterable and unsortable for everyone — closing off probing a never-rendered value. New in 1.2.0, a field may set `view_exempt_own_subject: true` to stand the view guard down when the record roots at the acting user's own account (host chain duck-typed on `getParentEntity()`, depth-capped, cycle-guarded, fail-closed; view only, no edit counterpart). Depends on core `field` and `user`; supports Drupal 10.6+, 11.3+, and 12 on PHP 8.1+.

---

- Hard-lock a sensitive field so no role, admin, or user 1 can read or edit it.
- Deny with `AccessResult::forbidden()` — a verdict Drupal's field-access folding cannot override.
- Require a permission to be explicitly named in a non-admin role's own configuration.
- Guard a field on `view`, on `edit`, or on both independently.
- Leave a field open for one operation by omitting that operation from the map.
- Nominate any existing site or contrib permission — Field Guard defines none of its own.
- Protect fields across entity forms, entity view, REST, and JSON:API from one config map.
- Block filtering and sorting on a guarded field in JSON:API and Views (definition-level deny).
- Stop an exposed date/number filter from binary-searching a never-rendered guarded value.
- Enforce separation of duty by making each access grant a reviewable line in a config diff.
- Keep the access map diffable and re-applied on every `drush config:import` deploy.
- Reject a mistyped operation key (`viewed`, `Edit`) at config-save time as a schema violation.
- Let a record's subject view their own data via `view_exempt_own_subject: true` (view only).
- Resolve nested Paragraph / inline-entity ownership through a duck-typed host-chain walk.
- Fail closed on an unresolvable, cyclic, orphaned, or over-deep host chain — exempt nothing.
- Keep edit guards, and the deny against every non-subject, in force even with the exemption on.
- Protect compliance, evidence, or attestation fields the site administrator must not silently rewrite.
- Lock personally-identifiable or regulated fields against inheritance-by-admin-role.
- Provide `ProtectedFieldMap::isProtected()` as a seam for an audit consumer to record reads.
- Deploy protection with zero UI surface — no admin form, no route, no custom permissions to manage.
- Add field-level denial without writing PHP — configuration only.
