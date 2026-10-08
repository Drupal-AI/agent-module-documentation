<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block plugin: resize_block (ResizeBlock)

File: `src/Plugin/Block/ResizeBlock.php`. Class `ResizeBlock extends BlockBase`.
Annotation `@Block(id = "resize_block", admin_label = @Translation("Resize block"))`.
No `blockForm`/`blockSubmit`/`blockAccess` overrides — the block has **no per-instance settings**
and placement is gated by core's `administer blocks` permission plus normal block visibility.

## Install / place
1. Enable: `drush en font_resize` (no dependencies).
2. Structure → Block layout → place "Resize block" in a region (e.g. header or sidebar).
3. Save. Nothing else to configure — there is no settings route (`configure` is null).

## build()
Returns a render array:
- `#type => 'markup'` with a fixed `#markup` string (labels run through `t()`):
  ```
  <div class="box">
    <a class="font_resize-button" id="font_resize-minus"   aria-label="Reduce Font Size"   tabindex="0" href="#">A-</a>
    <a class="font_resize-button" id="font_resize-default" aria-label="Reset Font Size"    tabindex="0" href="#">A</a>
    <a class="font_resize-button" id="font_resize-plus"    aria-label="Increase Font Size" tabindex="0" href="#">A+</a>
  </div>
  ```
- `#attached.library => ['font_resize/font_resize', 'font_resize/font_resize_example']`.
  The first is the jQuery plugin; the second is the initializer that binds it to `$('html')`.

Markup is static (no user/remote data interpolated). All three ids are fixed and are what the JS
looks for, so only place ONE instance of this block per page (duplicate ids would collide).

## Client behavior (`js/font_resize.js`, plugin `$.fn.font_resize`)
Plugin options (defaults, set by the example initializer):
`btnMinusId '#font_resize-minus'`, `btnDefaultId '#font_resize-default'`,
`btnPlusId '#font_resize-plus'`, `btnMinusMaxHits 10`, `btnPlusMaxHits 10`, `sizeChange 1`.

- On init it removes the `href` from the three buttons and sets `cursor:pointer`.
- **A+ (`btnPlusId`)**: while step count < `btnPlusMaxHits` (10), reads the target's computed
  `font-size`, adds `sizeChange` (1) px, writes it back; at the max it adds `font_resize-disabled`
  to the A+ button and re-enables A-.
- **A- (`btnMinusId`)**: while step count > `-btnMinusMaxHits` (−10), subtracts 1px; at the min it
  adds `font_resize-disabled` to the A- button and re-enables A+.
- **A (`btnDefaultId`)**: resets the step counter to 0, restores the remembered size, and clears
  `font_resize-disabled` from both buttons.
- **Keyboard**: a `keypress` of Enter (keyCode 13) on a focused button triggers its click, so the
  `tabindex="0"` links are operable without a mouse.

Note: the plugin remembers the "reset" size from the first A+/A- interaction, so the A (reset)
button restores the size captured at that first step, not necessarily a pre-recorded theme value.

## Scope of the resize
The shipped initializer applies the plugin to the `<html>` element. To make that cascade to page
text, the active theme must size text in relative units (em/rem) — see
[../theming/customize.md](../theming/customize.md) for the requirement and for targeting a
narrower selector.
