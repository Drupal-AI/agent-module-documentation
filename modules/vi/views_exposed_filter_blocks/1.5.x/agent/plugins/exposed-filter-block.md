<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `views_exposed_filter_blocks_block` Block plugin

The module defines exactly one plugin — a core Block plugin. It does **not** define any plugin
*type* of its own; you consume it, you do not implement against it.

```
Class:  Drupal\views_exposed_filter_blocks\Plugin\Block\ViewsExposedFilterBlocksBlock
@Block(
  id = "views_exposed_filter_blocks_block",
  category = @Translation("Views Exposed Filter Blocks"),
  admin_label = @Translation("Views exposed filter block")
)
```

## What `build()` does

1. Reads `view_display` (`"<view_id>:<display_id>"`) and splits it. Returns nothing if empty.
2. Loads the view with `Views::getView($view_id)`, `setDisplay($display_id)`, `initHandlers()`.
   If the view can't be loaded it logs an error (logger channel `type`) and renders it inline.
3. Builds core's exposed form `\Drupal\views\Form\ViewsExposedForm` via the form builder against
   a `FormState` seeded with `['view' => $view, 'display' => &$display, 'rerender' => TRUE]`,
   using **GET** (`setMethod('get')`) with `disableRedirect()`.
4. If `form_state_always_process` is TRUE, calls `setAlwaysProcess()` so submitted input is
   processed at build time.
5. If the target display's `link_display` is `custom_url` with a `link_url`, sets the form
   `#action` to that URL — this lets the filter block live on a **different page** than results.

## Caching

`getCacheMaxAge()` returns `0` — the block is never cached, so selected/exposed filter values
are always reflected. Do not wrap it in aggressive caching.

## Validation

`blockValidate()` requires `view_display` to split into a non-empty `view_id:display_id` and
that `Views::getView($view_id)` loads. So a saved block always references a real view.

## When to use this vs. alternatives

- **This module** — configured on the **block**; works for **any** display plugin (`eva`,
  `page`, `block`, attachment, feed). Pick the view/display in the block settings.
- **`views_block_filter_block`** — configured on the **view**; only for `block` display
  plugins. Use it if you only need block-display exposed filters.
- **Core "Exposed form in block"** — a `page` display can expose its own form in a block via
  the view's *Exposed form* settings; use that when you don't need the form on a non-page display.

## Implementing your own (not needed)

There is no plugin manager or interface to extend here. To alter the rendered exposed form,
use core's form alter hooks on `views_exposed_form` (e.g.
`hook_form_views_exposed_form_alter()`), not this module.
