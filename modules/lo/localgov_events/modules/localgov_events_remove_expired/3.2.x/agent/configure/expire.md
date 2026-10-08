# Configure expired-event clean-up

Settings form `ExpiredEventSettingsForm`
(`Drupal\localgov_events_remove_expired\Form\ExpiredEventSettingsForm`, form id
`localgov_events_remove_expired_form`) at **`/admin/config/content/expired-events`**
(route `localgov_events_remove_expired.form`, menu link under Configuration › Content authoring).
Requires permission `administer expired events`. It is a `ConfigFormBase` that edits the single config
object `localgov_events_remove_expired.settings` through `#config_target`.

## Settings

| Key | Form field | Type | Default | Meaning |
|---|---|---|---|---|
| `action` | radios "When events have expired:" | string | `none` | `none` = do nothing · `unpublish` = unpublish/archive · `delete` = permanently delete |
| `expire_days` | number "How many days after events expire should action be taken?" | int ≥ 0 | `30` | Days after an event's end before it is acted on. Action fires after the midnight following (end date + `expire_days`). |
| `items_per_cron` | number "…How many events in a batch?" | int ≥ 0 | `100` | Max nodes processed per cron run. `0` = no per-run limit. |

The `action` radio ships an in-form warning that deleted events may not be recoverable. Config schema
`config/schema/localgov_expired_events.schema.yml` types `expire_days` and `items_per_cron` as
integers with a `Regex` `^[0-9]+$` constraint ("Please enter numbers only"). Install defaults live in
`config/install/localgov_events_remove_expired.settings.yml` (`action: none`, `expire_days: 30`,
`items_per_cron: 100`).

## Set without the UI

Drush:

```bash
drush cget localgov_events_remove_expired.settings
drush cset localgov_events_remove_expired.settings action unpublish -y
drush cset localgov_events_remove_expired.settings expire_days 90 -y
drush cset localgov_events_remove_expired.settings items_per_cron 200 -y
drush cron
drush watchdog:show --type=localgov_events_remove_expired
```

PHP:

```php
\Drupal::configFactory()
  ->getEditable('localgov_events_remove_expired.settings')
  ->set('action', 'delete')
  ->set('expire_days', 30)
  ->set('items_per_cron', 100)
  ->save();
```

## What happens at runtime (hook_cron)

`localgov_events_remove_expired_cron()` runs on every cron:

1. Reads `action`, `expire_days`, `items_per_cron` from config.
2. Cut-off = `new DrupalDateTime('now', 'UTC')` → `modify('midnight')` → `modify("-{expire_days} days")`,
   formatted `Y-m-d\TH:i:s`.
3. Guards — each logs an error to channel `localgov_events_remove_expired` and returns: node type
   `localgov_event` exists; field `localgov_event_date` exists on it; that field is of type `date_recur`.
4. Resolves the occurrence table via
   `DateRecurOccurrences::getOccurrenceCacheStorageTableName($storageDef['localgov_event_date'])` and
   queries it directly (no entity query, because occurrence rows aren't reachable that way): distinct
   `entity_id` where `localgov_event_date_end_value` `<` cut-off, **excluding** any node that also has
   an occurrence `>=` cut-off (so only events entirely in the past match), joined to `node_field_data`
   on `status = 1` (published only), limited to `items_per_cron` when it is `> 0`.
5. Loads each matched node and acts on `action`:
   - `delete` → `$entity->delete()` (permanent, no confirmation, no archive).
   - `unpublish` → if `content_moderation` is enabled **and** the node has a `moderation_state` field,
     `ContentModerationState::loadFromModeratedEntity()` then
     `localgov_events_remove_expired__set_content_state($state, $entity, 'archived')` sets
     `moderation_state` to `archived` (only when the node's workflow actually defines an `archived`
     state); otherwise `$entity->setUnpublished()` + `save()`.
   - any other value (including `none`) → logs "No action has been specified." and leaves the node.
6. Every outcome logs to the `localgov_events_remove_expired` channel; a thrown exception is caught and
   its message logged.

Notes:

- The comparison is on the occurrence **end** value and only fully-past events are touched, so a
  recurring event stays live until its last occurrence has passed.
- `delete` has no recycle bin — validate `expire_days` on a copy of production before enabling it.
- Clearing a backlog of N expired events takes roughly `ceil(N / items_per_cron)` cron runs.
- On a moderated site, confirm the workflow attached to `localgov_event` defines an `archived` state,
  or `unpublish` will not archive (it silently no-ops the moderation path when the state is absent).
