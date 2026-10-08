# Drush commands

Registered in `drush.services.yml`.

| Command | Args / options | Effect |
|---|---|---|
| `node-revision-delete:queue` | `--type=<content_type>` | Queue nodes of a content type for revision deletion per its configured strategies (`Commands/QueueContent.php`). |
| `node-revision-delete:delete-prior-revisions <nid> <vid>` | `--langcode=<langcode>` | Delete all prior revisions of node `nid` before revision `vid` (`Commands/PriorRevisions.php`). |

Examples:
```
drush node-revision-delete:queue --type=article
drush node-revision-delete:delete-prior-revisions 123 4567
```

Queued items are processed by the `NodeRevisionDelete` queue worker (on cron, or
`drush queue:run`). Use these in scheduled maintenance scripts for hands-off pruning.
