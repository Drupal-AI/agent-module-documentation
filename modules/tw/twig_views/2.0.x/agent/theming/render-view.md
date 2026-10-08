# `render_view()` Twig function

Registered by the `twig_views.twig.render_view` service (`Drupal\twig_views\Twig\RenderView`,
tagged `twig.extension`). Available in every Twig template once the module is enabled.

## Signature

```twig
{{ render_view(view_id, display_id, arg1, arg2, ...) }}
```

- `view_id` (string, required) — the view's machine name, e.g. `content`, `frontpage`.
- `display_id` (string, required) — the display machine name, e.g. `page_1`, `block_1`, `default`.
  If omitted/empty an `\InvalidArgumentException` is thrown; an unknown display also throws.
- Any further positional arguments are passed to `$view->setArguments()` as the display's
  **contextual filter (argument) values**, in order.

## What it returns

A rendered string (the function is `is_safe => ['html']`, so it is printed unescaped). The output is:

```html
<h2>{{ view title }}</h2>
{{ rendered view output }}
```

The view's configured title (`$view->getTitle()`) is emitted in an `<h2>` (via a render array with
`#allowed_tags => ['h2']`), followed by `$view->render()`. Both are combined and passed through the
`renderer` service.

## Examples

```twig
{# A page/block display with no contextual filters #}
{{ render_view('frontpage', 'page_1') }}

{# Pass the current node ID as the first contextual argument #}
{{ render_view('related_content', 'block_1', node.id) }}

{# Multiple contextual arguments #}
{{ render_view('events_by_region', 'embed_1', term.id, 'upcoming') }}
```

## Notes / gotchas

- There is no built-in access re-check beyond what the view display itself enforces; the view renders
  with the current user's access like any embedded view.
- The `<h2>` title wrapper is always added — if you do not want a heading, set the display's title to
  empty or use core's block/area handlers instead.
- Passing arguments relies on the display actually defining contextual filters; extra args are ignored
  by displays without matching arguments.
