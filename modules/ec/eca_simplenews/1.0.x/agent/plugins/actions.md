<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA actions

Two ECA actions, both extending `\Drupal\eca\Plugin\Action\ConfigurableActionBase` and declared with
`#[Action(...)]` + `#[EcaAction(...)]` attributes (`version_introduced: '1.0.0'`). They appear in ECA's
action picker after enabling the module.

## Subscribe to newsletter

- **Id:** `eca_simplenews_subscribe_to_newsletter`
- **Class:** `src/Plugin/Action/SubscribeToNewsletterAction.php`
- **Label:** "Subscribe to newsletter"; description "Subscribe to simplenews newsletter."
- **Config form fields** (`buildConfigurationForm()`):
  - `mail` — textfield, required, `#eca_token_replacement => TRUE`, described as "Email address to be subscribed."
  - `newsletter_id` — textfield, required. The newsletter **machine name** (e.g. `default`).
- **`defaultConfiguration()`:** `['mail' => '', 'newsletter_id' => '']` (a `language` key is commented out).
- **`execute()`:** gets `\Drupal::service('simplenews.subscription_manager')`, resolves
  `$mail = \Drupal::token()->replace('[user:mail]')`, then calls
  `$subscriptionManager->subscribe($mail, $config['newsletter_id'], $config['language'] = NULL)`.

Caveat (from source): `execute()` subscribes the **`[user:mail]` token** (the acting user's address), **not**
the configured `mail` field value — the `mail` form value is collected/stored but ignored at execute time.
Language is always `NULL` (the third argument is an inline assignment `$config['language'] = NULL`; the
language form control is commented out with `@todo`s).

## Unsubscribe from newsletter

- **Id:** `eca_simplenews_unsubscribe_from_newsletter`
- **Class:** `src/Plugin/Action/UnsubscribeFromNewsletterAction.php`
- **Label:** "Unsubscribe from newsletter"; description "Unsubscribe from simplenews newsletter."
- **Config form fields:** same shape as Subscribe — `mail` (required, `#eca_token_replacement => TRUE`) and
  `newsletter_id` (required, machine name).
- **`execute()`:** resolves `$mail = \Drupal::token()->replace('[user:mail]')` and calls
  `$subscriptionManager->unsubscribe($mail, $config['newsletter_id'])`.
- **`access()`:** overridden to return `AccessResult::allowed()` unconditionally.

Same caveat: the unsubscribe target is the `[user:mail]` token, not the `mail` field.

## Notes

- Both actions call Simplenews' `simplenews.subscription_manager` service via `\Drupal::service()`
  (static call, no dependency injection).
- Neither action creates a newsletter, sends a newsletter/issue, or manages content — there is **no send
  action and no event** in this module. It only toggles subscription membership.
- To target the address you want, ensure the ECA execution context makes `[user:mail]` resolve to the
  intended user.
