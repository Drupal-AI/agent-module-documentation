# Embed syntax & rendering (`InsertView::build`)

The filter (`Drupal\insert_view_adv\Plugin\Filter\InsertView::process()`) recognises three ways
to embed a view and turns each into a render **placeholder** that calls the static
`InsertView::build($view_name, $display_id, $args, $configuration)`.

## 1. Token syntax `[view:name=display=args]`

```
[view:my_view]                       default display, no args
[view:my_view=my_display]            named display
[view:my_view=my_display=arg1/arg2]  display + contextual args (slash-separated)
[view:my_view==arg1/arg2]            default display + args (empty display segment)
```

If the display segment is numeric it is treated as an argument, not a display id; omit it and
the view's default display is used. This is the syntax shown by the filter `tips()`.

## 2. `<drupal-view>` tag (what the CKEditor 5 plugin stores)

```html
<drupal-view data-view-id="my_view" data-display-id="page_1" data-arguments="1/2"></drupal-view>
```

## 3. Legacy 1.x JSON blob

A JSON object containing `inserted_view_adv` and `arguments` keys is also recognised for
backward compatibility.

## `InsertView::build()` — what happens at render time

1. If the view is not in `allowed_views` (when that whitelist is set), return either the raw
   `[view:...]` token or nothing, per `render_as_empty`.
2. `Views::getView($view_name)`; bail (to the raw token/empty) if it doesn't exist.
3. **Access check:** `$view->access($display_id)` — a user without access gets the fallback,
   never the rendered view.
4. Arguments: split `args` on `/`; for any missing contextual filter it fills in the view's
   **default / exception argument** values so the view has a full argument set.
5. Return `$view->preview($display_id, $args)`.

Because `process()` wraps each embed in `createPlaceholder(...)`, the view renders in its own
placeholder — the host entity can be cached independently and **BigPipe** can stream the view
in. When views are actually inserted, the filter result adds cache tag `insert_view_adv` and
cache contexts `url`, `user.permissions`. `hide_argument_input` (a filter setting) strips
user-supplied args before building. `build` is registered as a trusted callback
(`TrustedCallbackInterface`).
