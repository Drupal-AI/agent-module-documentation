# Message Digest UI — agent index

Submodule that adds the user-facing side of Message Digest: a per-subscription and per-user
"notification interval" preference, wired through Flag + Message Subscribe Email. Each recipient
picks a digest interval (or "send immediately"); at notify time this module swaps their message
notifier to the chosen digest notifier. Depends on `message_digest`,
`message_subscribe:message_subscribe_email`, core `options`.

No settings page (no `configure` route), no permissions of its own, no drush. The "UI" is a
`message_digest` options field placed on the user account form and on the `email_*` flagging forms
(added by `hook_install`), plus derived Action plugins. Provides config schema for the action
configuration only.

- **The `message_digest` interval field (user + flaggings), its widget, allowed values, and how the
  chosen interval is stored** → [fields/interval.md](fields/interval.md)
- **The `message_digest_interval` Action plugin + deriver, and the shipped `system.action.*` configs** →
  [plugins/actions.md](plugins/actions.md)
- **The subscriber-alter hook that swaps the notifier to the digest one (+ implements-alter ordering)** →
  [hooks/hooks.md](hooks/hooks.md)

Parent module: [../../../../1.5.x/agent/start.md](../../../../1.5.x/agent/start.md)

Key facts:
- Field: `message_digest` — `list_string`, cardinality 1, `required: true` — on entity `user` (bundle
  `user`) and on `flagging` bundles `email_node` / `email_term` / `email_user`.
- Allowed values come from `message_digest_allowed_values_callback` (defined in the **parent** module's
  `.module`): key `'0'` = "Send immediately"; other keys = digest notifier plugin ids (e.g.
  `message_digest:daily`, `message_digest:weekly`).
- Stored value = the digest notifier plugin id to deliver with, or `'0'` for immediate. The flagging
  field's default is `message_digest_default_value_callback` (parent) = the owner's user-level
  `message_digest` value; the user field default is literal `'0'`.
- Action plugin id `message_digest_interval`, deriver `DigestIntervalActionDeriver`: one derivative per
  flag (`email_node` / `email_term` / `email_user`) × interval. `execute()` flags the **current user's**
  entity if needed then writes the interval onto that flagging; `access()` defers to
  `FlagInterface::actionAccess('flag', $account, $object)`.
- Notifier swap: `hook_message_subscribe_get_subscribers_alter()` reads each subscriber's own flagging
  `message_digest` value and calls `DeliveryCandidateInterface::setNotifiers([$notifier])`; `'0'`/null
  leaves immediate delivery. `hook_module_implements_alter()` makes it run after
  `message_subscribe_email`.
- Config schema key: `action.configuration.message_digest_interval:*:*` (`flag_id`, `value`).
