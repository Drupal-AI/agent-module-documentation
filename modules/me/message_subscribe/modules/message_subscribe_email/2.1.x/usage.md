Message Subscribe Email adds per-subscription email control on top of Message Subscribe: a parallel set of `email_*` flags decides which of a user's subscriptions actually send email, so a user can subscribe to many things but only be emailed about some.

---

Where the base module sends via whatever notifiers a recipient has, this submodule gates the `email`
notifier per subscription. It ships an `email_*` flag paired to each `subscribe_*` flag
(`email_node`↔`subscribe_node`, `email_term`, `email_user`) and a boolean **"Email subscriptions"**
field (`message_subscribe_email`) on the user account (default on) that governs the default. Its
`FlagEvents` event subscriber watches flag/unflag events: when a user flags a `subscribe_*` flag and
their `message_subscribe_email` preference is on, it auto-adds the matching `email_*` flag (and
removes it on unsubscribe). At send time, `hook_message_subscribe_get_subscribers_alter()` queries
which recipients hold the relevant `email_*` flag for the context and **adds the `email` notifier for
those users while removing it for everyone else** — so only email-flagged subscriptions get emailed.
`hook_flag_action_access()` prevents flagging an `email_*` flag unless the corresponding
`subscribe_*` flag is set, and the module repoints the UI's subscription Views to email-aware
variants (`subscribe_node_email`, etc.) on install. It adds its own "Email flag prefix" setting
(config `message_subscribe_email.settings:flag_prefix`, default `email`) to the base settings form.
Requires `message_subscribe_ui`.

---

- Let a user subscribe to lots of content but receive email for only some of it.
- Give each subscription an independent "email me about this" toggle via `email_*` flags.
- Default new subscriptions to email-on (or off) per user with the "Email subscriptions" account field.
- Automatically create the matching `email_node` flag when a user subscribes to a node.
- Automatically drop the email flag when a user unsubscribes.
- Ensure only users who opted into email for a specific item get the `email` notifier.
- Prevent users from email-flagging an item they haven't actually subscribed to.
- Present email toggles alongside subscriptions in the Subscriptions UI (email-aware Views).
- Change the email flag prefix (default `email`) to fit an existing flag scheme.
- Provide a "subscribe, but notify me by email only for important items" experience.
- Filter the notifier list so non-email subscribers are quietly skipped for email.
- Swap the base `subscribe_node`/`subscribe_term`/`subscribe_user` views to their `*_email` versions.
- Let editors manage which content types expose email flags via the shipped `email_*` flags.
- Use the `message_subscribe_email.manager` service to list all `email_*` flags in code.
- Respect a per-user email preference field when auto-creating email flags on subscribe.
- Combine subscribe + email flags so the UI shows two toggles per item (follow / email me).
- Keep in-app/other-channel subscriptions while gating only the email channel per item.
- Migrate an existing follow feature to add opt-in email notifications per subscription.
- Ensure email notifications respect the user's global "Email subscriptions" account setting.
- Build a newsletter-style opt-in on top of Flag + Message Subscribe.
