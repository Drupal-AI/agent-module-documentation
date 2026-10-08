<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Gate — what changed (1.6.x → 1.8.0)

Two intermediate releases sit between the 1.6.x docs and this branch: **1.7.0** and **1.8.0**. Both are
bugfix-focused; the delivery mechanism, endpoints, and gate methods are unchanged.

## 1.7.0 — Identity-aware mint hardening (d.o #3618403)

When a mint request names an acting account (`account` UUID or `uid`), the grant is now capped to that
account's rights across four checks instead of just file-download access:

1. file download access;
2. **view access on every referencing host** entity (including a `user` host);
3. **view access on the referencing field** (a field-level deny is no longer skipped);
4. **view access on each `getParentEntity()` ancestor** when the file's usage host is a child
   (paragraph / inline).

A gated file with **no resolvable host is refused**. Logic lives in `HostAccess::actingAccountMayReach()`
and `ParentWalker`. This is opt-in: an anonymous lead-capture mint (no `account`/`uid`) skips it.

## 1.8.0 — Two config-round-trip fixes

- **`require_identity_mint` is no longer stripped on save (d.o #3619534).** The mint controller enforces
  `require_identity_mint` for *every* gate method, but before 1.8.0 only `assurance` exposed the checkbox on
  the field settings form. `signed_url` and `token` rebuilt their settings from their own form values, so a
  config-imported `require_identity_mint: true` was silently removed the moment an editor pressed **Save** on
  the field — downgrading an identity-bound grant to an unbound signed URL, with nothing logged. Every
  mintable method (`signed_url`, `token`, and by inheritance `referrer_lock`) now renders the checkbox and
  round-trips the value; `assurance` inherits the control instead of duplicating it.
- **Grant-inventory routes honour the configured flood settings (d.o #3619535).** `GrantInventoryController`
  read `mint_flood_limit` / `mint_flood_window` — keys that do not exist in the schema — so any configured
  value was ignored in favour of a hard-coded 50/60 fallback. Both inventory routes
  (`GET /api/file-gate/grants`, `POST /api/file-gate/grants/revoke-bulk`) now read `flood_limit` /
  `flood_window`, the same keys the mint route applies.

Both fixes ship with kernel tests pinning the round-trip / throttle behaviour.

## Unchanged since 1.6.x

`hook_file_download()` deny-by-default (`-1`) contract; the mint/download/revoke/otp/otp-session/grants
endpoints; the eight gate methods; the config-import scheme validator and `hook_requirements()` guard for a
public-scheme gated field; named/dual-key secret rotation; the "mint authorizes nothing" trust boundary.
