<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Disk Quota — calculation & enforcement API

All logic is procedural in `disk_quota.module` (+ `disk_quota.theme.inc`). No services/classes to
inject; call the functions directly or rely on the hooks.

## Effective limit resolution

- `disk_quota_get_user_max_quota(?$account): int` — the effective limit in bytes. Returns the
  per-user override if non-zero, else the highest role limit.
- `disk_quota_get_user_user_quota(?$account): int` — per-user override, read from `user.data`
  (module `disk_quota`, name `limit`), passed through `Bytes::toNumber()`. `0` if unset.
- `disk_quota_get_user_role_max_quota(?$account): int` — loops the user's roles, reads
  `disk_quota.settings:role_<rid>`, returns the **maximum** (not the sum).
- Override storage: `disk_quota_set_user_quota($account, $bytes)` sets `user.data`
  `disk_quota:limit` when non-empty, deletes it when empty. Anonymous users are ignored.
  `disk_quota_user_delete()` (`hook_user_delete`) deletes the override on account deletion.

## Usage counting

- `disk_quota_get_user_disk_quota(?$account): int` → wraps `disk_quota_file_space_used(uid)`.
- `disk_quota_file_space_used(?int $uid, string|int $status = 'all'): int` — the core measurement.
  Uses the `file` storage **aggregate query** (`getAggregateQuery()->accessCheck(FALSE)`) with
  `aggregate('filesize', 'SUM')`, condition on `uid`, and (when `$status !== 'all'`) on `status`
  (`0` temporary, `1` permanent). `accessCheck(FALSE)` is intentional so the sum reflects all of a
  user's files regardless of the viewer; it returns only a summed byte count, never file content.
  When `file_types` is set, adds an OR group over `filemime` (`image%` / `video%` LIKE; documents =
  NOT LIKE image AND NOT LIKE video). Tags the query `disk_quota_get_user_quota`.

## Which files count — `disk_quota_is_file_tracked(FileInterface): bool`

Returns TRUE when `file_types` is empty (track everything). Otherwise maps the file's MIME prefix
(`image`/`video`/other→documents) to whether that type is in `file_types`.

## Enforcement — `disk_quota_file_validate(FileInterface): array` (hook_file_validate)

Runs on every managed file save. Skips when owner is **user 1** or the file is not tracked. Then:
- If `max > 0` and used ≥ max → error "you have reached your storage limit".
- Else if `max > 0` and `file size + used > max` → error "file is too large" with used/max.
Returns an array of translated error strings (empty = allowed). Enforcement therefore covers any
upload path that saves a `file` entity through validation; files added outside Drupal are not
counted or blocked.

## Pre-upload warning — `disk_quota_get_user_disk_quota_warning(?$account)`

Wired via `hook_element_info_alter()` which appends `disk_quota_file_field_process` to the
`#process` of `managed_file` and `plupload` elements. On initial (non-AJAX) build it compares used
vs. `warning_percentage`% of max and adds a messenger error (at/over limit) or warning (over
threshold). No-op when max is 0.

## Display field & theme

- `hook_entity_extra_field_info()` adds display component `disk_quota` ("Storage Usage") to
  `user`/`user`. Enable it on *Manage display* for the user view mode.
- `disk_quota_user_view()` renders it only when the component is enabled AND the viewer has
  `edit any storage quota`, or is viewing their own account with `view own storage quota`.
- Theme hook `disk_quota` (`hook_theme`) → `disk-quota.html.twig`, preprocessed by
  `template_preprocess_disk_quota()` (`disk_quota.theme.inc`): formats used/max with
  `ByteSizeMarkup` and builds a percentage sentence, with edge cases for "no limit" (max 0) and
  "no files yet" (used 0), and different wording for own vs. other accounts.

## User form integration

- `disk_quota_form_user_form_alter()` adds a "Storage Quota" fieldset with a "Storage limit"
  textfield (`disk_quota_limit`), gated by `disk_quota_can_user_edit_disk_quota()`; default shown
  as `ByteSizeMarkup` of the current override. Appends `disk_quota_form_user_form_submit` to the
  submit handlers.
- `disk_quota_form_user_form_submit()` → `disk_quota_set_user_quota($account, Bytes::toNumber(value))`.
  An empty value deletes the override (falls back to role limits).

## Help page — `disk_quota_help()`

On `help.page.disk_quota` returns `README.md`; if the `markdown` module is enabled it renders the
markdown filter, else wraps the raw text in `<pre>`.
