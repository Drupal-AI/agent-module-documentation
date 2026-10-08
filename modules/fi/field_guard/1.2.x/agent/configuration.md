<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Guard — configuration & mechanics

No admin form and no route. Field Guard is driven entirely by the
`field_guard.settings` config object (schema: `config/schema/field_guard.schema.yml`),
edited in your config sync directory and applied with `drush config:import`.

## The protected map

```yaml
# field_guard.settings.yml
protected:
  profile:                        # <entity_type>
    compliance_record:            # <bundle>
      field_evidence_date:        # <field_name>
        view: 'view compliance evidence'   # <operation>: <permission>
        edit: 'record compliance evidence'
```

Nesting: `protected.<entity_type>.<bundle>.<field_name>.<operation>` → the
permission required for that operation.

- **Operations are only `view` and `edit`** — the only ones Drupal's field-access
  API passes. Any other key (`viewed`, `Edit`, `delete`) is treated as unprotected.
  The operation level is modelled as a closed `view`/`edit` mapping in the schema, so
  a typo is a save-time schema violation rather than a field that silently claims
  protection while staying open.
- **An omitted operation is not protected.** Omission is how you deliberately leave a
  field open for that operation.
- **An empty permission string is treated as unset**, not as "a permission nobody
  holds" — that would be an invisible total denial that is hard to diagnose.
- **A base field with no bundle context (bundle NULL) is never matched.**
- **Ships empty** (`protected: {}`), so enabling the module changes nothing until you
  configure it.
- Config rather than code is deliberate: it is diffable, reviewable, and reverted to
  the repository on every deploy that runs `drush config:import`, so a live edit that
  widens access does not survive a release.

Field Guard **defines no permissions of its own** — nominate any permission your site
or another module already provides.

## How the verdict is decided (`hook_entity_field_access`)

1. Look up the field's required permission for the operation via
   `ProtectedFieldMap::requiredPermission()`. No entry → `AccessResult::neutral()`
   (this module only ever denies; neutral folds away and cannot widen another
   module's restriction).
2. **Definition-level check (`$items === NULL`)** → `AccessResult::forbidden()`. This
   is the filter/sort question JSON:API (`FieldResolver::getFieldAccess()`) and Views
   (`EntityField::access()`) ask with no entity in scope. Denying it removes the Views
   handler and blocks the JSON:API filter, so a never-rendered guarded value cannot be
   binary-searched with an exposed filter or ordered by a sort. Consequence: guarded
   fields are **unfilterable and unsortable for everyone**, permission holders
   included. Carries only the map's cache tags (`config:field_guard.settings`) — no
   user context, because the answer is identical for every account.
3. **Value-level check** → `AccessResult::forbiddenIf(!explicitlyGranted)`. The grant
   test walks the account's roles, **skips `is_admin` roles**, and asks each remaining
   role's own permission list directly — deliberately NOT
   `AccountInterface::hasPermission()`, which returns TRUE for every permission on an
   `is_admin` role or uid 1. Carries `user.roles` + `user.permissions` contexts plus
   the map dependency.

Because the deny is `forbidden()` and `EntityAccessControlHandler::fieldAccess()`
folds hook results with `orIf()` (where forbidden is contagious) and contains no
admin bypass, the denial holds against `administer *` permissions, `is_admin` roles,
and user 1.

## Own-subject view exemption (new in 1.2.0)

```yaml
protected:
  paragraph:
    client_document:
      field_client_file:
        view: 'manage client documents'
        view_exempt_own_subject: true
```

`view_exempt_own_subject: true` (only a boolean `true`; any other value fails closed)
makes the **view** guard stand aside — returning `neutral()`, so ordinary entity and
field access decide — when the entity carrying the field ultimately roots at the
acting user's own account.

- The host chain is resolved by `HostChainWalker::chain()`, duck-typed on
  `getParentEntity()` (Paragraphs / inline entities and friends), capped at depth 8
  and cycle-guarded. An unresolvable chain returns NULL and **fails closed**; an
  orphan or a root that is not the acting `UserInterface` account exempts nothing;
  **anonymous is never a subject**.
- **View only.** There is deliberately no edit counterpart — a record its subject can
  rewrite is not evidence. The `edit` guard on the same field is untouched.
- **The definition-level (filter/sort) deny is untouched** — with no entity there is
  no subject, so probing stays closed for everyone.
- Non-subjects on a flagged field get the ordinary explicit-grant verdict
  (administrators and uid 1 still denied; named permission holders still pass).
- Cacheability: the exempt (neutral) arm carries the `user` context and every chain
  entity as a cacheable dependency; the non-subject arm additionally carries
  `user.roles` + `user.permissions`.

## Boundaries (properties of Drupal, not gaps)

- **Programmatic reads.** `$entity->get('field')->value` and Drush never call
  `fieldAccess()`.
- **Views filters/sorts/arguments on *unguarded* fields.** `HandlerBase::access()`
  returns TRUE unconditionally; guarding at definition level is the only lever.
- **Direct SQL / anything below the entity API sees everything.**
- **No audit logging** — Drupal does not log field reads.
  `ProtectedFieldMap::isProtected()` is the seam for a consumer that wants to record
  them.
- **Do not guard workflow fields (`moderation_state`, `status`) on `edit`.** A
  JSON:API/REST PATCH checks field edit-access against the **stored** value
  (`EntityResource::checkPatchFieldAccess()`), so an edit-guard there forbids
  legitimate transitions. Use a validation constraint for transition policy; guard
  `view` freely.
