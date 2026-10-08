# Hook implementations (`message_digest_ui.module`)

The submodule has no services and no routes; its runtime behavior is two hook implementations that
divert Message Subscribe Email delivery to a digest notifier based on each recipient's stored interval.

## `hook_message_subscribe_get_subscribers_alter(array &$uids, array $values)`

Invoked by `message_subscribe` while building the recipient list for a message. `$uids` maps each
subscriber uid → a `DeliveryCandidateInterface`; `$values['context']` maps entity_type → the entity ids
being notified about. Flow:

1. Return early if `$uids` is empty.
2. Get the email flags via `\Drupal::service('message_subscribe_email.manager')->getFlags()`; return if
   there are none. Collect their flag ids.
3. For each `entity_type => entity_ids` in `$values['context']`, query the `flagging` storage for
   flaggings matching `flag_id IN (email flags)`, `uid IN (array_keys($uids))`, `entity_type`, and
   `entity_id IN (entity_ids)`, sorted by `message_digest`, with `accessCheck(TRUE)`.
4. Build `$digest_mapping[uid]`:
   - if any matching flagging has a null/empty (`'0'`) `message_digest` value → set the uid to `FALSE`
     (this message must be sent immediately for that user, and it wins over any digest value);
   - otherwise record the first non-empty `message_digest` value (the notifier plugin id) for that uid.
5. For each `uid => $delivery_candidate` in `$uids`, if `$digest_mapping[$uid]` is truthy, call
   `$delivery_candidate->setNotifiers([$notifier])` — **replacing all** notifiers with the single chosen
   digest notifier. Immediate (`FALSE`) users are left untouched.

The query is scoped to `uid IN array_keys($uids)` (the users `message_subscribe` already resolved as
subscribers) and each candidate only ever reads its own flagging value, so a user's selection affects
only that user's delivery.

## `hook_module_implements_alter(&$implementations, $hook)`

For `$hook === 'message_subscribe_get_subscribers_alter'`, moves `message_digest_ui` to the end of the
implementation list so its notifier swap runs **after** `message_subscribe_email` has populated the email
notifiers on each delivery candidate.

## `hook_install()` (`message_digest_ui.install`)

Not a runtime hook but relevant to integrators: on install it adds the `options_select` widget for the
`message_digest` field to the `user` form display and to each `email_*` flagging form display (see
[../fields/interval.md](../fields/interval.md)).
