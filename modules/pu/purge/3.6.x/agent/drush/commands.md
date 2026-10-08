# Drush commands (p:*)

Shipped in `purge` core (`src/Drush/Commands/`, `drush.services.yml`). The deprecated
`purge_drush` submodule only exists to auto-enable them and is not needed on modern Drush.

## Invalidation & diagnostics
- `p:invalidate <type> [expression]` — directly invalidate, e.g. `drush p:invalidate tag node:1`,
  `drush p:invalidate everything`, `drush p:invalidate url https://…`.
- `p:diagnostics` — list diagnostic check results (fitness of the configuration).
- `p:types` — list supported invalidation types across installed purgers.

## Queue
- `p:queue-add <type> <expression>` — add an item to the queue.
- `p:queue-work` — claim and process a chunk of the queue.
- `p:queue-browse` / `p:queue-stats` / `p:queue-volume` — inspect the queue.
- `p:queue-empty` — clear the queue.

## Manage plugins
- Purgers: `p:purger-ls`, `p:purger-lsa` (available), `p:purger-add`, `p:purger-rm`,
  `p:purger-mvu` / `p:purger-mvd` (reorder up/down).
- Processors: `p:processor-ls`, `p:processor-lsa`, `p:processor-add`, `p:processor-rm`.
- Queuers: `p:queuer-ls`, `p:queuer-lsa`, `p:queuer-add`, `p:queuer-rm`.
- Debug logging: `p:debug-en`, `p:debug-dis`.

Most commands accept `--format=json` for scripting.
