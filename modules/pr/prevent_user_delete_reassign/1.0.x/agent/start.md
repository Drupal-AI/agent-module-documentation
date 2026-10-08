<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Prevent User Delete Reassign (prevent_user_delete_reassign) — agent index

Removes the **"Delete the account and make its content belong to the Anonymous user"** cancellation
method (`user_cancel_reassign`) from Drupal's two account-cancellation forms. Purely two
`hook_form_FORM_ID_alter()` implementations in `prevent_user_delete_reassign.module`: each checks for
and `unset()`s `$form['user_cancel_method']['#options']['user_cancel_reassign']`, then adds a
messenger warning built by the private helper `_prevent_user_delete_reassign_status_message()`. No
config, no routes, no services, no schema — the entire module is that one `.module` file plus the
`.info.yml`.

Why the option matters: of core's four cancel methods, `user_cancel_reassign` keeps the user's nodes,
comments and files but sets the author to Anonymous — the content survives, the authorship record
does not, irreversibly. It also interacts with core bug
[#2977362](https://www.drupal.org/project/drupal/issues/2977362), where cancelling an author can
republish old revisions as the default. Removing the option forces admins toward the safer
alternatives (block, block-and-unpublish, or delete-with-content). Scope is form-only: it changes
what the two forms offer; it does not touch programmatic `user_cancel()` calls, `drush user:cancel`,
or site scripts that pass a cancel method explicitly.

- **Depends on:** core `user` (`.info.yml` `dependencies`).
- **Core:** `^8 || ^9 || ^10 || ^11`. **Version:** 1.0.2. **Package:** none declared. **License:** GPL-2.0-or-later.
- **Settings page / configure route:** none. **Permissions:** none (defines none of its own). **Drush:** none. **Services:** none. **Plugin types:** none. **Config schema:** none.
- Trivial module — correctly start-only, no topic files.

## Key facts (real machine names)
- **Hooks implemented (both in `prevent_user_delete_reassign.module`):**
  - `prevent_user_delete_reassign_form_user_cancel_form_alter()` — alters form id `user_cancel_form`
    (single-account cancel, route `entity.user.cancel_form`, path `/user/{user}/cancel`).
  - `prevent_user_delete_reassign_form_user_multiple_cancel_confirm_alter()` — alters form id
    `user_multiple_cancel_confirm` (bulk cancel, path `/admin/people/cancel`).
- **Private helper:** `_prevent_user_delete_reassign_status_message()` — returns the translatable
  warning shown via `\Drupal::messenger()->addWarning()` when the option is stripped.
- **Form element touched:** `user_cancel_method` (a `radios` element built from core
  `user_cancel_methods()`); the module removes only the `#options` key `user_cancel_reassign`.
- **Options left intact:** `user_cancel_block`, `user_cancel_block_unpublish`, `user_cancel_delete`.
- **Note for agents:** in core, `user_cancel_method` is `#access`-gated on `administer users` OR
  `select account cancellation method`; the module does not change that gate, only the option list.
