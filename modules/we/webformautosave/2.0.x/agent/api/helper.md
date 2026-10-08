<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks, the autosave flow & `webformautosave.helper`

Source: `webformautosave.module`, `src/AutosaveHelper.php`, `js/webformautosave.js`.

## The autosave flow (no custom endpoint)

1. `hook_webform_submission_form_alter` runs on every webform submission form. It calls
   `AutosaveHelper::enableAutosave($webform, $submission)` — TRUE only if `auto_save` is on and the
   webform's total/user/entity submission limits are not exceeded.
2. If enabled and the submission already has an id, it injects a **hidden, disabled** submit button
   (`webformautosave_hidden_save_draft`) with `#validate=['::draft']`, `#submit=['::submitForm','::save']`
   and an `#ajax` callback (`webformautosave_ajax_handler`) — i.e. it reuses Webform's own draft-save
   pipeline. A new submission with drafts+purge enabled is first saved as a draft (`in_draft = TRUE`).
3. It attaches library `webformautosave/webformautosave` and
   `drupalSettings.webformautosave.forms[<webform_id>].autosaveTime`.
4. `js/webformautosave.js` (jQuery + once) binds input/change listeners; after the debounce it clicks
   the hidden button, triggering the AJAX draft save.

Because everything goes through the standard Webform submission form and its
`getTokenUrl()` draft token, **access control is core Webform's** — this module adds no route,
controller, or REST resource (the old REST endpoints/permissions were deleted in
`webformautosave_update_8002`).

## Optimistic locking

- On form build, if `optimistic_locking` is on, the latest submission-log timestamp is stored in
  `$form_state` under `optimistic_timestamp_<submission-token>`, and
  `webformautosave_optimistic_locking_validate` is appended to `#validate`.
- On validate, it re-reads the current log (`getCurrentSubmissionLog`); if `last_change_time >
  stored_time` it sets an error on the first field with a "reload the data on this form" link
  (`getSubmissionUrl`, which re-applies current query params to the token URL).

## `AutosaveHelper` (service `webformautosave.helper`)

Constructor args: `@webform_submission_log.manager`, `@current_user`, `@entity_type.manager`,
`@request_stack`.

| Method | Purpose |
|---|---|
| `enableAutosave($webform, $submission): bool` | TRUE if `auto_save` on and total/user limits not hit. |
| `getCurrentSubmissionLog($submission): object` | Most recent submission-log row (unserialized with `allowed_classes => FALSE`); inserts+returns a fresh log if none. |
| `getSubmissionUrl($submission): Url` | Token URL for the latest submission, current query params re-applied. |
| `getCurrentFields($submission)` / `getFirstWebformField($submission)` | Elements on the current (wizard) page / the first field key. |
| `checkTotalLimit` / `checkUserLimit` (protected) | Enforce webform `limit_total*` / `limit_user*` / `entity_limit_*` before autosaving. |

## Other hooks

- `hook_webform_third_party_settings_form_alter` — renders the per-webform settings (see
  [../configure/settings.md](../configure/settings.md)).
- `hook_ENTITY_TYPE_presave` (webform) — auto-enables draft/purge/submission-log settings when
  autosave or optimistic locking is turned on.
