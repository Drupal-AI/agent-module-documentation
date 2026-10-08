# The `message_digest_interval` Action plugin

An entity **Action** (core `@Action`, id `message_digest_interval`) that sets a user's chosen digest
interval on a flagging — usable from Views Bulk Operations, admin actions, or programmatically. It does
NOT define a new plugin type; it plugs into core's action plugin type via a deriver.

- Plugin class: `Drupal\message_digest_ui\Plugin\Action\DigestInterval` (extends `ActionBase`).
- Deriver: `Drupal\message_digest_ui\Plugin\Derivative\DigestIntervalActionDeriver`.

## Derivatives

`DigestIntervalActionDeriver::getDerivativeDefinitions()` produces one derivative per **flag × interval**.
Flags are hardcoded (the flag service is not ready this early in install):

| flag_id | entity `type` |
| --- | --- |
| `email_node` | `node` |
| `email_term` | `taxonomy_term` |
| `email_user` | `user` |

Intervals come from `getDigestNotifiers()`: a leading `Send immediately` entry plus every notifier plugin
implementing `Drupal\message_digest\Plugin\Notifier\DigestInterface` (the `message_digest:` prefix is
stripped for the id segment). Derivative id = `{flag_id}:{interval-or-'immediate'}`, e.g.
`message_digest_interval:email_node:daily`, `message_digest_interval:email_user:immediate`.

## Behavior

- `access($object, $account, $return_as_object)` → returns `$this->flag->actionAccess('flag', $account, $object)`
  — i.e. it defers entirely to Flag's own access check for flagging `$object` as `$account`.
- `execute($entity)`:
  1. `$flagging = $this->flagService->getFlagging($this->flag, $entity)` — the **current user's** flagging
     for that entity (Flag's `getFlagging`/`flag` default to the current user);
  2. if none exists, `$this->flagService->flag($this->flag, $entity)` creates it (flags the entity for the
     current user);
  3. `$flagging->message_digest = $this->intervalPluginId;` then `$flagging->save()`.

The `flag_id` and target `value` (interval) come from plugin configuration, injected by the shipped
`system.action.*` config entities below. The action therefore only ever changes the acting user's own
flagging.

## Shipped action configs (`config/optional`)

Nine `system.action.message_digest_interval.*` entities install (one per `email_{node,term,user}` ×
`{immediate,daily,weekly}`). Each is `optional` config depending on `message_digest_ui`, the matching
`flag.flag.email_*`, and (for non-immediate) the `message_digest.interval.*` config from the parent.

| Action id | `type` | `configuration.flag_id` | `configuration.value` |
| --- | --- | --- | --- |
| `message_digest_interval.email_node.immediate` | node | email_node | `0` |
| `message_digest_interval.email_node.daily` | node | email_node | `message_digest:daily` |
| `message_digest_interval.email_node.weekly` | node | email_node | `message_digest:weekly` |
| `message_digest_interval.email_term.immediate` | taxonomy_term | email_term | `0` |
| `message_digest_interval.email_term.daily` | taxonomy_term | email_term | `message_digest:daily` |
| `message_digest_interval.email_term.weekly` | taxonomy_term | email_term | `message_digest:weekly` |
| `message_digest_interval.email_user.immediate` | user | email_user | `0` |
| `message_digest_interval.email_user.daily` | user | email_user | `message_digest:daily` |
| `message_digest_interval.email_user.weekly` | user | email_user | `message_digest:weekly` |

`value: '0'` means the action sets the flagging back to immediate delivery.

## Config schema

```yaml
action.configuration.message_digest_interval:*:*:
  type: mapping
  mapping:
    flag_id: { type: string }   # e.g. email_node
    value:   { type: string }   # digest notifier plugin id, or '0'
```

## Notes

- `message_digest_ui_post_update_rename_action_plugins()` (in `.post_update.php`) migrated old action
  `plugin` ids that used `.` as the derivative separator to `:` (dots are disallowed in plugin ids). New
  installs already use `:`; this only matters for sites updating from an older release.
