<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File access rules, download hook, render filtering & private .htaccess guard

Three cooperating pieces control who can download or see managed files, plus a guard that keeps the
private root protected.

## `file_access_rule` config entity + `FileAccessEvaluator`

`FileAccessRule` (`src/Entity/FileAccessRule.php`, config prefix
`accessible_file_manager.access_rule.*`, admin perm **administer file access rules**) stores a
weighted, enable-able rule: `scope` is either `path` (matched by scheme + glob `path_pattern`, where
`**` → `.*` and `*` → `[^/]*`, anchored with `(?:$|/)`) or a reference scope (matched by
`entity_type` + `bundle` + `field_name` against the file's current references). Each rule carries
grant/deny role and user lists, an `owner_policy` (`allow`/`deny`/none), and a time window
(`valid_from`, `valid_until`, or `duration_seconds` measured from the file's created time).

`FileAccessEvaluator::evaluate()` (`src/FileAccessEvaluator.php`) collects matching active rules in
weight order and requires **every** matching rule to grant (`evaluateMatchingRules`): a rule denies
outright on a deny-list hit, owner-deny, or an expired/not-yet-valid window; it grants on a
grant-list or owner-allow hit; otherwise `no_grant` (fails the whole set). With **no** matching
rule the default is `public_default_allow` for public URIs and **`private_default_deny`** for
private URIs — i.e. private files are deny-by-default under this evaluator. The result is wrapped in
a cacheable `FileAccessDecision` (`src/FileAccessDecision.php`) with `user` context and
`config:file_access_rule_list` / `file:<id>` tags. References come from
`FileEntityReferenceResolver`.

## `hook_file_download` (`accessible_file_manager.module`)

`accessible_file_manager_file_download($uri)` acts only on `private://` URIs and only on GET
(non-GET → `-1`). It loads the File entity, runs the evaluator for the current user, and returns
`-1` (deny) when the decision is not allowed; on allow it marks a download-counter candidate and
returns inline `Content-Type` / `Content-Disposition` / `nosniff` headers. Because Drupal honours a
`-1` from any implementation, this hook can only **further restrict** private downloads on top of
core's own `file_file_download` access check — it never broadens access beyond what core grants.

## Render-time filtering — `FileRenderAccessFilter`

`hook_entity_view_alter` runs `FileRenderAccessFilter::filter()` (`src/FileRenderAccessFilter.php`)
on every rendered content entity. For each file/image field it evaluates each file and `unset()`s
denied deltas; for media reference fields it drops a media item if **any** managed file inside it is
denied (`mediaFilesAllowed`). Empty field wrappers are removed, and per-file cacheability is merged
in — so denied items disappear from output without leaving hollow markup, and the cache varies by
user + rule config.

## Private `.htaccess` security guard

`PrivateHtaccessSecurityGuard::ensure()` (`src/PrivateHtaccessSecurityGuard.php`) compares the
private root's `.htaccess` against Drupal core's canonical `FileSecurity::htaccessLines(TRUE)` using
`hash_equals` over sha256 (bounded to 16 KB read). If the root is missing it prepares it
(`CREATE_DIRECTORY | MODIFY_PERMISSIONS`); if the protection file is missing/modified it rewrites it
with `FileSecurity::writeHtaccess`, re-verifies, and logs a critical alert. A shared lock prevents
cron/web races. It runs from `hook_cron` and from `PrivateFilesystemGuardSubscriber`
(`KernelEvents::REQUEST` priority 30) on every `accessible_file_manager.*` /
`entity.accessible_file_manager_*` route, stashing the result in a request attribute that
`FileExplorerController::browse()` reuses. Statuses `unavailable` / `repair_failed` /
`verification_failed` surface an admin error and a recoverable explorer build instead of exposing a
raw exception.
