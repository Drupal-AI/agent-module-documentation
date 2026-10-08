# Settings

Config object `breadcrumb_manager.config` (schema `config/schema/breadcrumb_manager.config.yml`).
Form: `/admin/config/user-interface/breadcrumb-manager`
(`BreadcrumbManagerConfigForm`, route `breadcrumb_manager.breadcrumb_manager_config_form`,
permission `administer breadcrumb manager`).

## Keys (defaults from `config/install/breadcrumb_manager.config.yml`)
| Key | Default | Meaning |
|---|---|---|
| `excluded_paths` | `/user` | Paths not affected by the module (form textarea, one per line; `*` wildcard). Matched with `PathMatcher::matchPath`. When `show_front` is off, the front page path is also excluded. |
| `show_front` | `0` | Show the breadcrumb on the front page. |
| `show_home` | `1` | Prepend a "Home" link. |
| `home` | `''` | Override the "Home" link label (empty → "Home"). |
| `show_current` | `1` | Include the current page as the last segment. |
| `show_current_as_link` | `1` | Render the last segment as a link (vs plain text via `<none>` route). |
| `show_fake_segments` | `0` | Include path segments that have no matching route (rendered via `raw_path_component`, then passed through `hook_breadcrumb_manager_fake_segments_alter`). |
| `title_resolvers` | see below | Per-resolver `enabled` (bool) + `weight` (int), edited in a drag-and-drop table. |

Default `title_resolvers`:
```yaml
title_resolvers:
  menu_link_title:  { enabled: 1, weight: 0 }
  request_title:    { enabled: 1, weight: 1 }
  raw_path_component: { enabled: 1, weight: 100 }
```

## Build behavior (`BreadcrumbManagerBuilder::build`)
- Skips the front page unless `show_front`.
- Walks parent path segments; for each, matches a route, checks access (segments the user cannot
  access are skipped and their cacheability merged), then asks the enabled resolvers (in weight
  order) for a title — first non-empty wins.
- `applies()` returns false for excluded paths.
- Adds cache contexts `url`, `url.path.parent` and cache tag `config:breadcrumb_manager.config`.

## Drush
```
drush config:set breadcrumb_manager.config show_home 0 -y
drush config:set breadcrumb_manager.config home 'Start' -y
```
