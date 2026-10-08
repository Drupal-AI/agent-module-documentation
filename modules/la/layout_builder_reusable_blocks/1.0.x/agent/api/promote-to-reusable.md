<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Promote inline → reusable — `layout_builder_reusable_blocks_configure_block_submit_handler`

In `layout_builder_reusable_blocks.module`. Appended (by the add-block alter, step two) to the
Layout Builder configure-block submit chain. Runs only when the user chose the reusable path:

```
if ($form_state->get('layout_builder_reusable_make_reusable')) { … }
```

## What it does

1. Reads the placed `$component = $form_state->get('layout_builder__component')` and its
   `InlineBlock` plugin.
2. Grabs the block entity that core's InlineBlock add form built:
   `$block_content = $form['settings']['block_form']['#block'];`
3. If present:
   - `$block_content->setReusable(TRUE);` — flips the `block_content` entity from inline to a
     library (reusable) block.
   - `$block_content->set('info', $form_state->getValue('info'));` — stores the required Admin title.
   - `$block_content->save();`
   - **Rewires the component** away from the inline plugin to reference the now-library block:
     ```
     $component->setConfiguration([
       'id' => 'block_content:' . $block_content->uuid(),
       'label' => $block_plugin->label(),
       'label_display' => $form_state->getValue(['settings', 'label_display']),
       'provider' => 'block_content',
       'status' => true,
       'info' => "",
       'view_mode' => $block_plugin->getConfiguration()['view_mode'],
     ]);
     ```
   - Persists the layout to tempstore:
     `\Drupal::service('layout_builder.tempstore_repository')->set($form_object->getSectionStorage());`
     (the layout still needs the normal Layout Builder "Save layout" to become permanent.)

## Notes for agents

- This is the module's **only** promote path: an inline block becomes reusable *at creation time*,
  by choosing "Create reusable block" before saving. There is **no** contextual "Make reusable"
  action route/link for an already-placed inline block, despite the README wording — see
  [../reference/behavior-notes.md](../reference/behavior-notes.md).
- Access: gated by Layout Builder's configure-block access on the layout (core). The module adds no
  extra permission and does not consult `administer layout builder reusable blocks` here. The
  `setReusable(TRUE)` + `save()` runs in the same request as a user already permitted to create the
  inline `block_content` via Layout Builder, so it does not grant a create right the user lacked.
