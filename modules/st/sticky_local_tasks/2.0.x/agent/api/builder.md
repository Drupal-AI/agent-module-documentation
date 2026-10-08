# Builder service — render sticky tasks from code

Service `sticky_local_tasks.builder` → `Drupal\sticky_local_tasks\StickyLocalTasksBuilder`
(defined in `sticky_local_tasks.services.yml`, `autowire: true`). Use it in `block` usage mode or when
you want the tabs in a specific template/preprocess instead of on every page.

## Public methods

```php
public function build(Position $position): array;
public function addToPage(array &$build): void;
```

- `build(Position $position)` — returns the render array (`#theme => 'menu_local_tasks__sticky_local_tasks'`)
  for the current route's local tasks at the given position. Returns an (empty-ish) build carrying only
  cacheability when the route has fewer than 2 visible tasks. It reads `sticky_local_tasks.settings`
  `usage_options` to decide which libraries/classes to attach (`gin`, `hide-default-local-tasks`,
  dark theme, `rememberToggledState`), so those global options still apply in `block`/custom-code mode.
- `addToPage(array &$build)` — the `usage: all` entry point, invoked from `hook_page_bottom()`; applies
  the route/admin/login restrictions described in [configure/settings.md](../configure/settings.md).

## Position enum

`Drupal\sticky_local_tasks\Position` (string-backed):

| Case | Value |
|---|---|
| `Position::BottomLeft` | `bottom-left` |
| `Position::BottomRight` | `bottom-right` |

`Position::values()` returns `['bottom-left', 'bottom-right']` (used as the config `Choice` callback).

## Custom-code example

```php
use Drupal\sticky_local_tasks\Position;

$position = Position::BottomLeft;
$build = \Drupal::service('sticky_local_tasks.builder')->build($position);
// $build is a render array; return it from a controller, block, or preprocess.
```

Set the config `usage` to `block` first (so the tabs are not also auto-added to every page). The render
array attaches `sticky_local_tasks/sticky-local-tasks` and any option-driven libraries itself.
