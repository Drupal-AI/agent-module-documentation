<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Registered via `drush.services.yml` (service `node_by_email.commands`,
`Drupal\node_by_email\Commands\NodeByEmailCommands`). The module's `composer.json` requires `drush/drush: ^11.0`.

| Command | Alias | Does |
|---|---|---|
| `node_by_email:generate_node` | `nbe-gn` | Fetches the unseen mail list (`IMAPService::getUnseenEmailList()` = `imap_search FROM "<from_email>" UNSEEN`) and, for each message id, calls `MidToNodeService::createNodeFromMid($mid)` to create the node(s) and mark the mail Seen+Flagged. Prints `creating node for mid: <mid>` per message, or `No unseen email found.` |

No arguments or options. Run:

```
drush node_by_email:generate_node
drush nbe-gn
```

Requires the config object to have valid IMAP credentials and at least one `node_types` entry
(otherwise mail is marked Seen but no node is created).
