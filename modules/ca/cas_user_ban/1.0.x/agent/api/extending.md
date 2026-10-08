<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extending: UserCancelFormsTrait & FilterUserCancelMethodEvent

## UserCancelFormsTrait
`Drupal\cas_user_ban\Traits\UserCancelFormsTrait` lets a custom user-cancel form or action add the "ban on
cancel" behaviour. It expects the using class to have `$currentUser` (AccountProxyInterface), `$casUserManager`
(`cas`'s `CasUserManager`), `$casUserBanManager`, `$eventDispatcher`, `$messenger` and string translation
available (see `Hook\UserCancelFormsHooks` and the VBO `CancelUserAction` for the constructor/DI wiring).

Key members:
- `protected static array $allowedCancelMethods = ['user_cancel_reassign', 'user_cancel_delete']` — default
  cancel methods that expose the ban option.
- `addBanField(array &$form, FormStateInterface $form_state, array $uids, ?array &$submit_element = NULL)` —
  builds a `ban_cas_usernames` checkbox visible/checked (via `#states`) only for allowed methods. It resolves
  each uid to a CAS username with `getCasUsernameForAccount()`, **skips the current user** and any uid without a
  CAS username, stores the resolved usernames in `$form_state->set('cas_usernames', …)`, and appends
  `banSubmit` to the passed submit element.
- `banSubmit(array $form, FormStateInterface $form_state)` — runs on submit; bans the stored usernames only if
  the checkbox is set **and** the chosen `user_cancel_method` is in the allowed list.
- `banUser(string $cas_username)` — calls `CasUserBanManager::add()`, showing a status or (on
  `ExistingBanException`) warning message.

Usage (from README): import the trait, then in `buildForm`/`buildConfigurationForm` call
`$this->addBanField($form, $form_state, $uids, $form['actions']['submit']['#submit'])`.

## FilterUserCancelMethodEvent
`Drupal\cas_user_ban\Event\FilterUserCancelMethodEvent` (name const `cas_user_ban.filter_user_cancel_method`)
is dispatched by `getCancelMethodsWithBanOption()` for every form that uses the trait. Subscribe to it and call
`setAllowedMethods()` / `getAllowedMethods()` to change which cancel methods show the ban option (e.g. to also
allow it on a custom cancel method). It carries an array of method machine names.
