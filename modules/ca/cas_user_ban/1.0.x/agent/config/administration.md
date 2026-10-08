<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, admin UI & form integration

## Routes (all require `_permission: 'administer users'`)
From `cas_user_ban.routing.yml`:
- `cas_user_ban.banned_users_list` — `/admin/people/cas/banned-users-list`, controller
  `Controller\BannedUsersListController` (invokable). Shows a paged table (20/page via `PagerSelectExtender`)
  of `cas_username` + banned date (`DateFormatter`, medium), each with an AJAX-modal **Delete** link. Added as a
  secondary task tab on the People collection (`cas_user_ban.links.task.yml`).
- `cas_user_ban.ban_users` — `/admin/people/cas/ban_users`, `Form\BanUsersForm`. Textarea (one username per line);
  submit builds a Batch that bans each non-empty, not-already-banned username, reporting three result buckets
  (already banned / banned-but-has-account / banned). Exposed as an action link on the list page
  (`cas_user_ban.links.action.yml`).
- `cas_user_ban.remove_user_ban` — `/admin/people/cas/remove-user-ban/{cas_username}`, `Form\RemoveBanForm`
  (a `ConfirmFormBase`). `buildForm()` throws `NotFoundHttpException` if the username is not banned; confirming
  calls `CasUserBanManager::remove()`. CSRF-protected as a POST confirm form.

The banned username is rendered through the `table` theme cell `data` and through `%`-placeholder / `Link`
helpers on the confirm and validation messages (Twig/`FormattableMarkup` autoescaping applies).

## Form alters (class hooks, `src/Hook/`, bridged by `cas_user_ban.module` `#[LegacyHook]` wrappers)
- `UserCancelFormsHooks::alter` → `hook_form_user_cancel_form_alter`: on core single-user cancel, adds a
  `ban_cas_usernames` checkbox ("Prevent user from re-creating the account.") and a `banSubmit` handler.
- `UserCancelFormsHooks::multipleAlter` → `hook_form_user_multiple_cancel_confirm_alter`: same for the multiple
  cancel confirm form, using the accounts' uids.
- `BulkAddCasUsersHooks::alter` → `hook_form_bulk_add_cas_users_alter`: adds `validateBannedUsers` element
  validation to CAS's Bulk Add form so banned usernames are rejected with an error linking to the ban list.

The checkbox/submit wiring is implemented in `Traits\UserCancelFormsTrait` (see `agent/api/extending.md`); it
skips the current user (`$this->currentUser->getAccount()->id() == $uid`) and any uid without a CAS username, and
only shows for allowed cancel methods (`user_cancel_reassign`, `user_cancel_delete` by default).
