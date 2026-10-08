<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Defined in `Drupal\acquia_perz_push\Commands\QueueCommands` (registered via
`drush.services.yml`, tag `drush.command`).

| Command | Alias | Does |
|---|---|---|
| `acquia:perz-enqueue-content` | `ap-ec` | Rescan all personalization-eligible content and add it to the bulk export queue (`ExportQueue::rescanContentBulk()`), then run the batch. |
| `acquia:perz-process-queue` | `ap-pq` | Export the queued items to CIS (`exportBulkQueueItems()`), then run the batch. |
| `acquia:perz-queue-items` | `ap-qi` | Print the number of items currently in the export queue. |
| `acquia:perz-purge-queue` | `ap-pq` | Purge all items from the local export queue (does not touch CIS). |
| `acquia:perz-purge-current` | `ap-pc` | Delete **this site's** content from the Personalization service (interactive confirm). |
| `acquia:perz-purge-all` | `ap-pa` | Delete **all sites'** content from the Personalization service (interactive confirm). |

Note: `ap-pq` is declared as the alias for **both** `acquia:perz-process-queue` and
`acquia:perz-purge-queue` in the source — prefer the full command names to avoid ambiguity.

Typical re-export flow after changing view-mode opt-ins:

```bash
drush acquia:perz-enqueue-content   # scan + enqueue
drush acquia:perz-queue-items       # how many queued?
drush acquia:perz-process-queue     # push to CIS
```

The purge-current / purge-all commands prompt for confirmation (default No) and call
`ClientFactory::deleteContentFromCis()` / `deleteAllContentsFromCis()`.
