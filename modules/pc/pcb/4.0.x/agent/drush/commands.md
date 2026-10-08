<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# pcb Drush commands

Registered via `drush.services.yml` → `Drupal\pcb\Commands\PcbCommands` (constructor arg
`@cache_factory`).

| Command | Aliases | Args | Behavior |
|---|---|---|---|
| `pcb:flush` | `pcbf`, `permanent-cache-bin-flush` | `<bin>` | Flush one permanent bin. Loads `cache.<bin>` via the cache factory; if it has `deleteAllPermanent()` it calls it and logs success, else errors "`<bin>` bin is not using pcb". Invalid bin → "not a valid cache bin". |
| `pcb:flush-all` | `pcb-flush-all`, `permanent-cache-bin-flush-all` | — | Confirms, then iterates `Cache::getBins()` and calls `deleteAllPermanent()` on every bin that has the method. |
| `pcb:list` | `pcb-list`, `permanent-cache-bin-list` | — | Prints the machine name of each registered bin whose backend has `deleteAllPermanent()` (i.e. is using a pcb permanent backend). |

Examples:

```bash
drush pcbf stock            # clear the 'stock' permanent bin
drush pcb:flush-all         # clear every permanent bin (prompts for confirmation)
drush pcb-list              # which bins use a permanent backend
```

Notes for an agent:

- `pcbf`/`pcb:flush` resolve the bin through `cache_factory->get(<bin>)`, so a bin only counts as
  "using pcb" when its backend is one of pcb's permanent backends (has `deleteAllPermanent()`).
- `pcb:list` and `pcb:flush-all` only see bins registered in the container (`Cache::getBins()`);
  an ad-hoc bin created directly from the factory is not listed.
- These commands clear permanent bins; a normal `drush cr` deliberately does **not** touch them.
