<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# History (Node History) — agent index

Core's old `history` module, now contrib for Drupal `>11.3`. Tracks *which node each
authenticated user has read, and when*, in a single `history` table. **No configuration, no
permissions, no admin UI, no Drush, no plugin types.**

- **Table, functions, `HistoryManager`, routes, libraries, cleanup rules** →
  [api/read-tracking.md](api/read-tracking.md)
- **Views field + filter, the `node_new_comments` field, and the token** →
  [api/views-and-tokens.md](api/views-and-tokens.md)

Key facts:
- Table `history` — columns `uid`, `nid`, `timestamp`; primary key `(uid, nid)`; index on `nid`.
- `HISTORY_READ_LIMIT` = request time − 30 days. Older rows are deleted on cron and anything
  older is considered read.
- API: `history_read($nid)`, `history_read_multiple($nids)`, `history_write($nid, $account = NULL)`,
  and the service `Drupal\history\HistoryManager` (autowired, service id = the class name)
  with `getCountNewComments($entity, $field_name = NULL, $timestamp = 0)`.
- Views: field/filter id **`history_user_timestamp`** ("Has new content"), field
  **`node_new_comments`** ("New comments").
- Token: `[<entity_type>:comment-count-new]` on every entity type that has comment fields.
- Only anonymous-safe by design: `history_write()` is a no-op for anonymous users.
