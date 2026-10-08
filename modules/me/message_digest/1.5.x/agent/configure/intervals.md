# Configure digest intervals

Digest intervals are **config entities** (`message_digest_interval`). Each one automatically produces a Digest
notifier plugin (see plugins/notifiers.md).

## Admin UI
- Collection: `entity.message_digest_interval.collection` → `/admin/config/message/message-digest`
  (perm `administer message digest`), listed under Message settings.
- Add / edit / delete: `.../interval/add`, `.../manage/{message_digest_interval}`, `.../manage/{id}/delete`
  (entity create/update/delete access).

## Entity shape (schema `message_digest.schema.yml`, `message_digest.interval.*`)
| Key | Type | Meaning |
|---|---|---|
| `id` | string | Machine id (becomes the notifier derivative id, e.g. `daily`). |
| `label` | label | Human label (notifier title). |
| `description` | text | Description shown in field option lists. |
| `interval` | string | A `strtotime()`-compatible interval, e.g. `1 day`, `1 week`, `3 days`. |

## Shipped defaults (`config/install`)
- `message_digest.interval.daily` — `interval: '1 day'`.
- `message_digest.interval.weekly` — `interval: '1 week'`.

## Add a custom interval with Drush
```php
// drush php:eval — a 3-day digest, notifier id becomes message_digest:threeday
\Drupal::entityTypeManager()->getStorage('message_digest_interval')->create([
  'id' => 'threeday',
  'label' => 'Every 3 days',
  'description' => 'Sends messages in 3 day intervals.',
  'interval' => '3 days',
])->save();
```
After saving, clear caches so the notifier deriver picks it up (`ddev drush cr`). The new notifier is then
usable as `$notifier_name = 'message_digest:threeday'`.

The `interval` string is fed to `strtotime()` when computing the next send window per user (tracked in State by
`DigestBase`/`DigestManager`).
