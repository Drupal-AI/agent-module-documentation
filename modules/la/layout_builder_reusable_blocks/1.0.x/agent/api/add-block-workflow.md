<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add-block workflow — `hook_form_layout_builder_add_block_alter`

All in `layout_builder_reusable_blocks.module`. The alter targets Layout Builder's
`layout_builder_add_block` form and only acts on a custom **InlineBlock** component:

```
$component = $form_state->get('layout_builder__component');
if (!$component || !$component->getPlugin() instanceof InlineBlock) { return; }
```

So placing a normal library block, or any non-InlineBlock plugin, is untouched.

## State machine

Two `$form_state` flags drive a two-step flow:
`layout_builder_reusable_step_two` and `layout_builder_reusable_make_reusable`.

- **Step one, `make_all_blocks_reusable` config = TRUE** → `_auto_set_reusable()`: sets both flags,
  `setRebuild()`, then `_handle_reusable_block_form()`. The inline/reusable choice is skipped and the
  block is treated as reusable.
- **Step one, config = FALSE** → `_show_choice_buttons()`: removes the default submit, retitles the
  form *"What type of block do you want to create?"*, hides `$form['settings']` (`#access = FALSE`),
  adds a description and two AJAX submit buttons:
  - **Create inline block** — `data-layout-builder-reusable-action = 'inline'`
  - **Create reusable block** — `data-layout-builder-reusable-action = 'reusable'`
  Both use `#submit => ['layout_builder_reusable_blocks_add_block_submit_handler']`,
  `#limit_validation_errors => []`, and `#ajax` callback
  `layout_builder_reusable_blocks_ajax_callback` (which just returns `$form`).
- **Step two, `make_reusable` = TRUE** → `_handle_reusable_block_form()`: adds a required
  **Admin title** textfield (`$form['info']`, weight -100) and appends
  `layout_builder_reusable_blocks_configure_block_submit_handler` to the real submit button's
  `#submit`.

## Submit handler `layout_builder_reusable_blocks_add_block_submit_handler`

Reads the clicked button's `data-layout-builder-reusable-action`; if `'reusable'`, sets
`layout_builder_reusable_make_reusable = TRUE`. Always sets `layout_builder_reusable_step_two = TRUE`
and `setRebuild()` so step two (the actual block configuration form) renders.

If the user picks **inline**, no reusable flag is set and the flow continues as core's normal inline
block creation — the module adds nothing further.

## Access

This is a **form alter**, not a new route. The add-block form is already reachable only by users
with Layout Builder access to the layout being edited (core's `layout_builder` access checks). The
module does not add or relax any access check here; `administer layout builder reusable blocks` is
**not** consulted in this flow.

The actual "promote to reusable" work happens in the *other* submit handler on step-two save →
[promote-to-reusable.md](promote-to-reusable.md).
