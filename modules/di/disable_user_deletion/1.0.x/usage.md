<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Disable user deletion hides selected account-cancellation methods (delete, delete + reassign, block + unpublish) from Drupal's user cancel forms, so admins are steered away from destructive "delete the account" choices.

---

The module implements `hook_form_FORM_ID_alter` on the two core account-cancellation forms —
`user_cancel_form` (single) and `user_multiple_cancel_confirm` (bulk) — and, for each cancellation
method the admin has ticked on the settings form, sets `#access = FALSE` on that method's radio option
so it no longer renders, showing a warning that some options were disabled. The three toggles live in
config `disable_user_deletion.settings` (`user_cancel_reassign`, `user_cancel_delete`,
`user_cancel_block_unpublish`, matching core's `user_cancel_*` method ids). The settings form is at
`/admin/config/disable_user_deletion/settings` (route `disable_user_deletion.settings_form`) and is
gated by the core `administer site configuration` permission; the module defines **no permission of its
own**. **Important limitation:** this is a UI-only guard — it hides radio options via form `#access`
but does not add server-side validation, and the parent `user_cancel_method` radios still carry all of
core's options, so it does not by itself harden against a crafted POST. It is a guardrail for trusted
admins, not an access-control mechanism (the actual ability to cancel accounts is core's
`administer users` / cancel-account capability).

---

- Hide the "Delete the account and its content" option from the user cancel form.
- Hide "Delete the account and make its content belong to Anonymous" (reassign).
- Hide "Disable the account and unpublish its content" (block + unpublish).
- Steer admins toward safe account-cancellation choices by removing destructive ones.
- Reduce accidental permanent user deletions on multi-admin sites.
- Apply the same restriction to the bulk (multiple) cancel-confirm form.
- Show a warning telling admins to contact the technical administrator for disabled options.
- Toggle each cancellation method independently from one settings form.
- Leave "block" (the non-destructive default) available while hiding deletion.
- Enforce an organizational policy of "never hard-delete users" at the UI level.
- Configure the toggles via config management / `drush cset` for deployment.
- Pair with proper role/permission scoping (this module does not replace access control).
- Prevent site-builders from casually offering "delete account" during user cancellation.
- Keep content authorship intact by discouraging reassign/delete choices.
- Present a clear message pointing users to a technical administrator for restricted actions.
- Deploy the same deletion policy across environments via exported config.
- Audit which cancellation methods are hidden by reading `disable_user_deletion.settings`.
- Combine with a content-archival workflow where users are blocked rather than deleted.

