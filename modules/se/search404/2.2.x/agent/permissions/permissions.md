# Permissions & access

Search 404 defines **no permissions of its own** (there is no `search404.permissions.yml`). It
relies entirely on core permissions declared in `search404.routing.yml`:

| Route | Path | Requirement |
|---|---|---|
| `search404.page` | `/search404` | `access content` (the 404 landing/results page) |
| `search404.settings` | `/admin/config/search/search404` | `administer search` (the settings form) |

Additionally, the results are only rendered when core Search is enabled **and** the current user
has `search content` (or `search by page`) — otherwise the controller falls back to a plain
not-found message (`Search404Controller::search404Page`).

- Grant `administer search` (core, trusted) to whoever configures the 404-search behavior.
- Anonymous/authenticated users need `access content` to reach `/search404`, and `search content`
  for a search to actually run.

```
drush role:perm:add editor 'administer search'
```
