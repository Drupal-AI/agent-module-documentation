<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Status Popup (user_status_popup) — agent index

Block/activate users from a modal confirm form. Version **2.0.1**. Route names are namespaced
`nwc_user_status.*`.

- **Routes**: `nwc_user_status.user_block` and `nwc_user_status.user_active`, both gated by
  `administer users`; `ConfirmFormBase` forms call `$user->block()`/`activate()`.
- **UI**: `hook_form_user_form_alter` swaps the core status checkbox for a use-ajax modal button,
  only for users with `administer users`. Also provides a Views field `user_status_action_views_field`.
- **Note**: the confirm forms return to the referring page. No anonymous access.
