# Services, queue, cron, drush, actions & integrations (API)

## Core service — `push_framework.service`

`Drupal\push_framework\Service` (args: `push_framework.source.plugin.manager`,
`advancedqueue.processor`, `database`, `user.data`). Two public entry points:

```php
$service = \Drupal::service('push_framework.service');
$service->collectAllSourceItems(); // walk sources, dedup, enqueue pf_sourceitem jobs
$service->processQueue();           // run the advancedqueue.processor over the push_framework queue
```

- `collectAllSourceItems()` — instantiates every source plugin, iterates `getAllItemsForPush()`, skips
  recipients with the `push_framework`/`block push` user-data flag, skips already-queued items
  (`isItemQueued()` — matches `oid`+`uid` on non-`success`/non-`failed` `pf_sourceitem` rows in the
  `advancedqueue` table), and enqueues `Job::create('pf_sourceitem', $item->toArray())`.
- `processQueue()` — delegates to `advancedqueue.processor->processQueue()` on the queue.
- `queue()` (protected) — lazily loads/creates the Advanced Queue entity id **`push_framework`**
  (label "Push Framework", backend `database`).

## Plugin managers

- `push_framework.channel.plugin.manager` → `ChannelPluginManager` — discovers
  `Plugin/PushFrameworkChannel`, alter hook `push_framework_channel_info`, sorts by config
  `order_<id>` ascending. See [../plugins/channel.md](../plugins/channel.md).
- `push_framework.source.plugin.manager` → `SourcePluginManager` — discovers
  `Plugin/PushFrameworkSource`, alter hook `push_framework_source_info`. See
  [../plugins/source.md](../plugins/source.md).
- `logger.channel.push_framework` — logger channel injected into every `ChannelBase`.

## Advanced Queue job — `pf_sourceitem`

`Plugin/AdvancedQueue/JobType/SourceItem` (`@AdvancedQueueJobType(id = "pf_sourceitem")`, injects both
plugin managers). `process(Job $job)`:
- rebuilds a `SourceItem` from the payload (`SourceItem::fromArray()`), calls `$item->process($channelPluginManager)`;
- if not fully delivered, writes the updated payload back and returns `JobResult::failure('', 99, 300)`
  (i.e. up to ~99 retries, 300-second delay) — this is the retry mechanism;
- returns `JobResult::success()` once the item's tasks are drained.

Payload shape: `{oid, uid, 'plugin id', initialized, tasks[]}`; each task is
`{'channel plugin id', attempt, 'mute subsequent until completed', 'skip subsequent on success'}`.

## Cron & drush

- `push_framework_cron()` (`push_framework.module`) calls `collectAllSourceItems()` **then**
  `processQueue()` on every cron run. Queued items therefore wait for the next cron unless a dedicated
  worker/drush call processes them sooner.
- Drush (`Drush\Commands\PushFrameworkCommands`, autodiscovered):
  - `pf:sources:collect` → `collectAllSourceItems()`
  - `pf:queue:process` → `processQueue()`

## Action plugins (`type = user`)

| Action id | Class | Access | Effect |
|---|---|---|---|
| `push_framework_notify` | `Plugin\Action\Notify` | allowed when the target is a `UserInterface` (and the configured channel + node type exist) | Builds an in-preview `Node` from the action config (`channel`, `node_type`, `body_field`, `subject`, `body`), then `prepareContent()` + `send()` on the chosen channel — an immediate, ad-hoc push. Configurable action. |
| `push_framework_notifications_allow` | `Plugin\Action\NotificationsAllow` | requires **`administer users`** | Clears the recipient's `block push` user-data flag. Ships as `config/optional` `system.action.push_framework_notifications_allow`. |
| `push_framework_notifications_block` | `Plugin\Action\NotificationsBlock` | requires **`administer users`** | Sets the `block push` flag (opt-out). Ships as `system.action.push_framework_notifications_block`. |

`NotificationsBase` (parent of allow/block) writes `user.data` `push_framework`/`block push`. `Notify`
is only reachable through the core Action/VBO execution surfaces (which gate who can run actions on
user entities); it changes no state, only emits a notification through the selected channel.

## User opt-out & mail

- Flag: `user.data` module `push_framework`, key `block push` (`Service::BLOCK_PUSH`). Honored by
  `collectAllSourceItems()` (skips the recipient) and by `push_framework_mail_alter()`, which sets
  `$message['send'] = FALSE` for **any** mail addressed to a user whose flag is set.
- Migrate destination `push_framework_user_data` (`Plugin/migrate/destination/BlockPushUserData`
  extends core `UserData`) imports these flags: expects row props `uid` and `flag`.

## Tokens

`push_framework.tokens.inc` defines token type **`push-object`** with `[push-object:label]` and
`[push-object:content]` (the rendered entity), used by the subject/body patterns. See
[../configure/settings.md](../configure/settings.md).

## DANSE recipient selection

`Plugin/DanseRecipientSelection/DirectPush` (abstract, implements `DirectPushInterface`) integrates
with the DANSE module: `push(PayloadInterface, ?SourcePluginInterface, ?string $oid)` instantiates the
channel named by `directPushChannelId()`, loads user 1 as the acting recipient, and calls
`prepareContent()` + `send()` immediately (bypassing the queue). `getRecipients()` returns `[]`. Used
by the `eca_push_framework` submodule to fire ECA-driven direct pushes.

## Alter hooks for integrators

- `hook_push_framework_channel_info(&$definitions)` — add/alter channel plugin definitions.
- `hook_push_framework_source_info(&$definitions)` — add/alter source plugin definitions.
