# Message Subscribe Email — agent index

Adds **per-subscription email control** on top of Message Subscribe: parallel `email_*` flags decide
which of a user's `subscribe_*` subscriptions actually email them. No settings form of its own
(`configure=null`); it injects one field into the base module's settings form.

- **The `email_*` flags, the pairing rule, the account field, FlagEvents, the notifier filter, the manager** →
  [configure/email-subscriptions.md](configure/email-subscriptions.md)

Key facts:
- Ships `email_*` flags paired to `subscribe_*` flags: `email_node`, `email_term`, `email_user`
  (each pairs with `subscribe_node`/`subscribe_term`/`subscribe_user` by shared suffix).
- Config `message_subscribe_email.settings:flag_prefix` (default `email`) — what marks an email flag;
  exposed as an "Email flag prefix" field on the base settings form (has config schema).
- Account boolean field `message_subscribe_email` ("Email subscriptions", default on) governs whether
  subscribing also email-flags.
- `FlagEvents` subscriber: on flag of a `subscribe_*` flag (and the user's field on) it flags the
  matching `email_*` flag; on unflag it removes it.
- `hook_message_subscribe_get_subscribers_alter()` adds the `email` notifier only for recipients
  holding the relevant `email_*` flag and removes it for everyone else.
- `hook_flag_action_access()` forbids flagging an `email_*` flag unless the paired `subscribe_*` is set.
- Service `message_subscribe_email.manager` (`getFlags()` → all `email_*` flags).
- Repoints the UI subscription views to `*_email` variants on install. Requires `message_subscribe_ui`.
