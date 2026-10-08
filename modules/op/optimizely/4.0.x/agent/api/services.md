<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services & helpers

| Service | Class | Purpose |
|---|---|---|
| `optimizely.lookuppath` | `Util\LookupPath` | Resolve a system path to its URL alias and back (args: `@language_manager`, `@path_alias.manager`), so path matching works for aliases. |
| `optimizely.pathchecker` | `Util\PathChecker` | Match a request path against a project's path patterns (`*` wildcards), using the lookup service (arg: `@optimizely.lookuppath`). |
| `optimizely.cacherefresher` | `Util\CacheRefresher` | Invalidate page caches by cache tag `optimizely:<path>` when a project's paths change; call `->doRefresh($paths)`. |

Static helper `Drupal\optimizely\Util\AccountId`:

- `AccountId::getId()` — read `optimizely.settings:optimizely_id`.
- `AccountId::setId($id)` — set and save it.
- `AccountId::deleteId()` — delete the whole `optimizely.settings` object.

Entity `Drupal\optimizely\Entity\Optimizely` getters: `getCode()`, `getState()`, `getPaths()`,
plus `id()` / `label()`.

There is no Drush command and no hook API (`{name}.api.php` is absent). The snippet is emitted
purely through `hook_page_attachments()` (see [configure/projects.md](../configure/projects.md)).
