<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA conditions

Three ECA conditions, all extending `\Drupal\eca\Plugin\ECA\Condition\ConditionBase` and declared with
`#[EcaCondition(...)]` (`version_introduced: '1.0.0'`). Each ends with `return $this->negationCheck($value)`,
so ECA's standard "negate" toggle is honored. Files under `src/Plugin/ECA/Condition/`.

## User is currently subscribed

- **Id:** `eca_simplenews_is_subscribed_condition`
- **Class:** `IsSubscribed.php`
- **Config:** `newsletter_id` (required textfield, machine name).
- **`evaluate()`:** `$mail = \Drupal::token()->replace('[user:mail]')`, then
  `$subscriber = \Drupal\simplenews\Entity\Subscriber::loadByMail($mail)`. Returns TRUE when the subscriber
  exists **and** `$subscriber->isActive()` **and** `$subscriber->isSubscribed($newsletter_id)`.

## User has ever subscribed

- **Id:** `eca_simplenews_has_subscribed_condition`
- **Class:** `HasSubscribed.php`
- **Config:** `newsletter_id` (required textfield, machine name).
- **`evaluate()`:** resolves `[user:mail]`, then returns
  `\Drupal::service('simplenews.subscription_manager')->hasSubscribed($mail, $newsletter_id)`.

## Check for self-unsubscribes

- **Id:** `eca_simplenews_check_for_self_unsubscribes`
- **Class:** `CheckForSelfUnsubscribesCondition.php`
- **Config:** none (no form; not `newsletter_id`-scoped).
- **`evaluate()`:** resolves `$entity = \Drupal::token()->replace('[entity]')` (treated as the subscriber's
  uid). Runs raw `\Drupal::database()` queries via the query builder (parameterized `condition()` calls):
  1. Selects `mail`, `uid` from `simplenews_subscriber` where `uid = [entity]`.
  2. If found, selects the most recent history row from `simplenews_subscriber_history` left-joined to
     `simplenews_subscriber_history__subscriptions`, filtered by that `mail`, `uid IN (0, uid)`, and
     `subscriptions_target_id IS NULL` (i.e. an unsubscribe), ordered `id DESC`, `range(0,1)`.
  Returns TRUE if such an unsubscribe history row exists.
- **Caveat (documented in the source comments):** Simplenews does **not** record the `newsletter_id` on an
  unsubscribe, so this checks whether the user unsubscribed from **any** newsletter — false positives are
  possible. Intended to guard against unwanted automatic re-subscribes; the maintainer suggests pairing it
  with a notification action to review flags.

## Notes

- `IsSubscribed`/`HasSubscribed` key off the `[user:mail]` token; `CheckForSelfUnsubscribes` keys off the
  `[entity]` token (subscriber uid). Ensure the ECA context makes those tokens resolve as intended.
- All three read Simplenews state only — they never mutate subscriptions.
