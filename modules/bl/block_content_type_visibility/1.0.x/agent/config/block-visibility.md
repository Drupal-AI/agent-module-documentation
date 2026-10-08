<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Show/Hide over core's node content-type block condition

This module has no config object, schema, routes, services, or plugins. It is a single form alter plus a
submit handler that improve the UI of Drupal core's existing `entity_bundle:node` block-visibility
condition (provided by the Node module). All logic is in
`src/Hook/BlockContentTypeVisibilityHooks.php`.

## Install / enable
```bash
composer require drupal/block_content_type_visibility   # only needs drupal/core ^11
drush en block_content_type_visibility
```
Requires core `block` and `node` (info.yml `dependencies`). Nothing to configure globally — there is no
settings route (`configure: null`).

## The form alter — `formBlockFormAlter($form, $form_state, $form_id)`
Registered via `#[Hook('form_block_form_alter')]`. Runs on every block config form (`block_form`).

1. Guard: only acts when `$form['visibility']['entity_bundle:node']` exists — i.e. core's "Content types"
   condition is on the form. If Node's condition isn't present, the module does nothing.
2. Reads the block's current visibility config:
   `$block = $form_state->getFormObject()->getEntity();`
   `$config = $block->getVisibilityConditions()->getConfiguration();`
   `$negate = $config['entity_bundle:node']['negate'] ?? FALSE;`
3. Injects a radios element at `$form['visibility']['entity_bundle:node']['visibility_mode']`:
   - `#options`: `show` => "Show for the selected content types", `hide` => "Hide for the selected content
     types".
   - `#default_value`: `$negate ? 'hide' : 'show'`.
   - `#weight => -10` so it sits above the bundle checkboxes.
4. Hides core's raw checkbox: sets
   `$form['visibility']['entity_bundle:node']['negate']['#access'] = FALSE` (kept in the form, just not
   shown).
5. Appends `formBlockFormSubmit` to `$form['#submit']`.

## The submit handler — `formBlockFormSubmit($form, $form_state)`
Converts the friendly radio back into the value core's condition expects:
- Reads `$visibility = $form_state->getValue('visibility')`.
- If `visibility.entity_bundle:node.visibility_mode` is set, computes
  `negate = ($visibility_mode === 'hide') ? 1 : 0`, writes it to
  `visibility['entity_bundle:node']['negate']`, then `unset()`s `visibility_mode`.
- Writes the array back with `$form_state->setValue('visibility', $visibility)`.

So `show` → `negate = 0` (block appears only on the selected bundles); `hide` → `negate = 1` (block
appears everywhere except them).

## Stored configuration
No module-owned config is written. The result is persisted by core in the block's
`visibility.entity_bundle:node` settings (`bundles` = selected node type machine names, `negate` =
0/1, plus `id`/`context_mapping`). `visibility_mode` is a transient form-only value and is removed before
save — it never lands in config. That is why this module ships no `config/schema`.

## Drupal < 11.1 compatibility
`block_content_type_visibility.module` checks `\Drupal::VERSION` and whether the `hook_collector` service
exists. When OOP hooks aren't supported (Drupal < 11.1), it defines procedural
`block_content_type_visibility_form_block_form_alter()` / `..._form_block_form_submit()` that new-up the
Hook class and delegate to the same methods — single source of truth. On 11.1+ these procedural functions
are not defined and the `#[Hook]` attribute drives discovery.

## Operating notes
- To use it: at `/admin/structure/block` place/configure a block, open Visibility → "Content types", pick
  Show or Hide, tick the content types, save.
- It is presentation only. Hiding a block does not restrict access to its content — do not rely on it for
  security. Bundle matching and cache contexts are handled entirely by core's Node condition.
