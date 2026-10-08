<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tag syntax and render mechanics

## Syntax

```
[view:name=display=args=limit:number]
```

Regex actually used (`InsertView::process()`):

```
/\[view:([^=\]]+)=?([^=\]]+)?=?([^=\]]+)?=?(?:limit:)?([\d]+)?\]/i
```

| Segment | Meaning | Omitted → |
|---|---|---|
| `name` | view **machine name** (`views.view.<name>`) | required |
| `display` | display id (`page_1`, `block_1`, `default`) | `default`; also `default` if the segment is numeric |
| `args` | contextual filter arguments, `/`-separated, same as a view URL | no arguments |
| `limit:N` | overrides items per page via `setItemsPerPage(N)`; `limit:0` = all rows | display's own pager |

Valid examples (from the filter's own tips):

```
[view:my_view]
[view:my_view=my_display]
[view:my_view=my_display=arg1/arg2/arg3]
[view:my_view==arg1/arg2/arg3]
[view:my_view=my_display=arg1/arg2/arg3=limit:5]
[view:my_view===limit:0]
```

### Path-derived arguments

Before the args string is exploded, every `%N` is replaced with the *N*th component of the
current internal path (`\Drupal::service('path.current')->getPath()`, exploded on `/`).
Any `%digit` left over is stripped along with its leading slash. So on `/node/12`,
`[view:related=block_1=%2]` passes `12` as the first contextual filter argument
(`%0` is the empty string before the leading slash, `%1` is `node`, `%2` is `12`).

## Render pipeline

```php
$result = new FilterProcessResult($text);
$view_output = $result->createPlaceholder(
  '\Drupal\insert_view\Plugin\Filter\InsertView::build',
  [$view_name, $display_id, $args, $limit]
);
```

- `build()` is registered through `TrustedCallbackInterface::trustedCallbacks()`.
- `build()` returns `['#attached' => [], '#markup' => '']` when
  `Views::getView($view_name)` is empty **or** `$view->access($display_id)` is FALSE — i.e.
  a bad view name or denied access silently renders nothing, no error.
- On success it returns `$view->preview($display_id, $args) ?? []`. Note `preview()`, not
  `buildRenderable()` — the view is executed inline in the placeholder's lazy build.
- `process()` adds cache tag `insert_view` and cache contexts `url`, `user.permissions` to the
  filter result (only when at least one tag matched).

## Calling it from code

Nothing here is a service; `build()` is a public static and can be called directly:

```php
$render = \Drupal\insert_view\Plugin\Filter\InsertView::build('frontpage', 'page_1', '', '5');
$html = \Drupal::service('renderer')->renderInIsolation($render);
```

To exercise the whole filter chain instead, use core's `check_markup()`:

```php
$html = (string) check_markup('[view:frontpage=page_1]', 'iv_editorial');
```

## Tips text

`tips(TRUE)` returns the long help shown on the *Text formats* filter tips page;
`tips(FALSE)` returns the short line "You may use [view:*name=display=args*] tags to display views."
