# The `message_digest` interval field

This submodule ships one field, `message_digest`, on two entity types. Its value is the digest
**notifier plugin id** to deliver a user's messages with, or `'0'` for immediate delivery. This is
where a user records "how often" they want notifications.

## Field storage (`config/optional`)

| Storage | Entity type | Type | Cardinality | Allowed-values function |
| --- | --- | --- | --- | --- |
| `field.storage.flagging.message_digest` | `flagging` | `list_string` | 1 | `message_digest_allowed_values_callback` |
| `field.storage.user.message_digest` | `user` | `list_string` | 1 | `message_digest_allowed_values_callback` |

`allowed_values` is empty; the option list is generated dynamically by
`message_digest_allowed_values_callback()` (defined in the **parent** `message_digest.module`, not
here). That callback returns:

- key `0` → `t('Send immediately')` (stored as the string `'0'`);
- one entry per notifier plugin that implements `Drupal\message_digest\Plugin\Notifier\DigestInterface`,
  keyed by its full plugin id (e.g. `message_digest:daily`, `message_digest:weekly`) with the notifier's
  `title` as the label.

So adding a new digest interval entity in the parent module automatically adds a new option here.

## Field instances (`config/optional`)

| Instance | Bundle | Label | Required | Default value |
| --- | --- | --- | --- | --- |
| `field.field.flagging.email_node.message_digest` | `email_node` | `Notification interval` | yes | `message_digest_default_value_callback` |
| `field.field.flagging.email_term.message_digest` | `email_term` | `Notification interval` | yes | `message_digest_default_value_callback` |
| `field.field.flagging.email_user.message_digest` | `email_user` | `Notification interval` | yes | `message_digest_default_value_callback` |
| `field.field.user.user.message_digest` | `user` | `Message digest interval` | yes | literal `'0'` |

`message_digest_default_value_callback()` (parent module) returns the **current** user's own
user-level `message_digest` value (falling back to `'0'`). So when a user first flags an item, the new
flagging inherits that user's global digest preference. The `email_*` flag bundles are the ones
provided by `message_subscribe_email` (its `flag_prefix`, `email`, joined with `_node`/`_term`/`_user`).

The instances are `optional` config: they install only if their dependencies (the matching
`flag.flag.email_*`, `field.storage.*`) already exist.

## Widget (added by `hook_install`)

`message_digest_ui_install()` attaches an `options_select` widget for `message_digest` to the default
**form displays**:

- `user` / `user` form display, and
- each `flagging` / `{flag_prefix}_{node,term,user}` form display (prefix read from
  `message_subscribe_email.settings:flag_prefix`).

It only sets the component if not already present, so re-enabling is safe.

## How the stored value is consumed

The value is the notifier plugin id used at send time. `hook_message_subscribe_get_subscribers_alter()`
(see [../hooks/hooks.md](../hooks/hooks.md)) reads each subscriber's **own** flagging value and, when it
is non-empty and not `'0'`, replaces that delivery candidate's notifiers with the single digest notifier
named by the value. A `'0'`/null value keeps immediate delivery. (The user-entity field acts as the
per-user default that seeds new flaggings via the default-value callback; the flagging value is what the
notify pipeline actually reads.)

## Setting values programmatically

```php
// Per-user default (seeds future flaggings for this user).
$user->set('message_digest', 'message_digest:weekly')->save();   // or '0' for immediate

// Per-subscription (one flagging) override.
$flagging->set('message_digest', 'message_digest:daily')->save();
```

Valid values are exactly the keys returned by `message_digest_allowed_values_callback` — `'0'` or a
digest notifier id such as `message_digest:daily` / `message_digest:weekly`, plus any custom interval
notifier added in the parent module.
