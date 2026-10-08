# Message Subscribe Email — how per-subscription email works

No standalone settings page. It adds one field ("Email flag prefix" →
`message_subscribe_email.settings:flag_prefix`, default `email`) to the base module's settings form
at `/admin/config/message/message-subscribe`. Everything else is flags + hooks.

## The pairing rule

For each subscription flag `<subscribe_prefix>_<suffix>` there must be an email flag
`<email_prefix>_<suffix>` (default prefixes `subscribe` / `email`). Shipped pairs (email flags are
optional config, **disabled by default** — enable and set bundles per your content):

| Subscribe flag | Email flag |
|---|---|
| `subscribe_node` | `email_node` |
| `subscribe_term` | `email_term` |
| `subscribe_user` | `email_user` |

A missing `email_*` partner makes `FlagEvents` throw `MessageSubscribeException` when the paired
`subscribe_*` flag is toggled.

## The account preference field

`message_subscribe_email` — a boolean field on the **user** entity, label "Email subscriptions",
default value `1`. Added to the user form on install (`boolean_checkbox`). When on, subscribing to
something also email-flags it; when off, subscriptions don't auto-create email flags.

## Runtime behavior

- **`FlagEvents` (event subscriber `message_subscribe_email.flag_subscriber`)** — on
  `ENTITY_FLAGGED` of a `subscribe_*` flag, if the owner's `message_subscribe_email` value is set it
  flags the matching `email_*` flag on the same entity; on `ENTITY_UNFLAGGED` it removes the email flag.
- **`hook_message_subscribe_get_subscribers_alter()`** — the gate. Loads all `email_*` flags
  (`message_subscribe_email.manager::getFlags()`), queries the `flagging` table for which recipients
  hold one for the context, then for each recipient whose delivery-candidate flags don't already
  include an email flag: **adds the `email` notifier if they email-flagged the item, removes it
  otherwise**. Net effect: only email-flagged subscriptions send email.
- **`hook_flag_action_access()`** — returns forbidden when trying to *flag* an `email_*` flag on an
  entity the user hasn't `subscribe_*`-flagged (you can't "email me" something you don't follow).
- **On install** (`hook_install`) — adds the account field to the user form display and repoints the
  UI's subscription views from `subscribe_node`/`subscribe_taxonomy_term`/`subscribe_user` to
  `subscribe_node_email`/`subscribe_taxonomy_term_email`/`subscribe_user_email` (via each flag's
  `message_subscribe_ui.view_name` third-party setting).

## Service

`message_subscribe_email.manager` (`Drupal\message_subscribe_email\Manager`): `getFlags()` returns
all flags whose id starts with `message_subscribe_email.settings:flag_prefix` (i.e. the `email_*` flags).

## Config

- `message_subscribe_email.settings` → `flag_prefix` (default `email`). Has config schema.
- Ships `email_*` flags, the `message_subscribe_email` user field storage+instance, and the
  `subscribe_*_email` views (config/optional).
