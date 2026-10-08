<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the masquerade grant works (`hook_masquerade_access`)

Masquerade Field does **not** implement its own switch route or access check. It participates in the
Masquerade module's access aggregation through `hook_masquerade_access()`.

## This module's implementation
`MasqueradeFieldHooks::masqueradeAccess()` (`#[Hook('masquerade_access')]`):
```
load current user entity
collect target_ids from its 'masquerade_as' field
if requested $target_account is in that set -> return TRUE
otherwise -> return NULL   (never returns FALSE)
```

## How core Masquerade aggregates it
`masquerade_target_user_access()` in `masquerade.module`:
1. Deny outright if already masquerading, or target == self.
2. `invokeAll('masquerade_access', [$user, $target])` collects all hook results.
3. **If any result is `FALSE` (strict) → deny.**
4. Otherwise → allow **iff at least one result is `TRUE`**.

Core's own `hook_masquerade_access` (in `MasqueradeHooks`): uid 1 may masquerade as anyone; target
uid 1 requires `masquerade as super user` (else returns `NULL`, not `FALSE`); `masquerade as any user`
grants all; per-role grants require `masquerade as <role>` for every role the target holds; else `NULL`.

## The consequence
Because this module returns `TRUE` for a listed target and core returns `NULL` (not `FALSE`) for
targets the requester lacks permission for, **a listed target is permitted even when the requester has
no core masquerade permission at all**, and even when the target is a privileged account or uid 1:

- Requester with `masquerade_as = [uid1]` and **no** `masquerade as super user`:
  results = `[masquerade_field: TRUE, core: NULL]` → no FALSE, one TRUE → **allowed**.

So a user's `masquerade_as` field is an explicit per-user allow list of masquerade targets (the
point of the module). The decision of who may add targets to a given user's list is governed by the
`edit masquerade field` permission (`restrict access: true`) plus edit access to that user account;
grant it deliberately, since it determines which accounts that user can then masquerade into.

## The switch path is core's, and is CSRF-protected
The link the formatter/Views handler render targets `entity.user.masquerade`
(`/user/{user}/masquerade`), which requires `_csrf_token: 'TRUE'`. `SwitchController::switchTo()` calls
`masquerade_switch_user_validate()` (maintenance-mode, self, already-masquerading, and
`masquerade_target_user_access()` checks) before `Masquerade::switchTo()`. There is **no** weaker,
non-CSRF or unchecked switch route added by this module.

## Session scope
While masquerading, the actor's capabilities are bounded only by the **target account's** permissions.
Listing any privileged account in a `masquerade_as` field hands that account's full authority to the
holder for the duration of the session.
