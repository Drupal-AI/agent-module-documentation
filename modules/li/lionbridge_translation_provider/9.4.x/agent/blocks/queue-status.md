<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block: Queue Status

`src/Plugin/Block/QueueStatusBlock.php`

```php
/**
 * @Block(
 *   id = "queue_status_block",
 *   admin_label = @Translation("Queue Status Block"),
 * )
 */
```

- **Plugin id:** `queue_status_block`
- **Build:** renders a two-column table (Queue Name, Items in Queue) showing the item count of
  the `export_translation_jobs_to_capi` queue via `\Drupal::service('queue')->get(...)->numberOfItems()`.
- **Styling:** the module attaches `tmgmt_contentapi/queue-status-block`
  (`css/queue_status_block.css`) for this block (libraries in `tmgmt_contentapi.libraries.yml`).

Place it like any block at `/admin/structure/block`. It gives editors/admins a quick view of
pending submission backlog. No configuration form beyond the block defaults.
