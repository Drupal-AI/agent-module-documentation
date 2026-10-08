# Block Form Alter hooks

Two hooks, dispatched by the module's single `hook_form_alter()` after it works out which
subsystem rendered the block form and what the block's plugin id / bundle is.

## `hook_block_plugin_form_alter(&$form, &$form_state, $plugin)`

Fires for **block plugin** configuration forms — any plugin **except** `block_content` and
`inline_block`. `$plugin` is the block plugin id (e.g. `system_powered_by_block`,
`views_block:...`, `webform_block`).

Dispatched for these render contexts:
- `block_form` (Block module placement/edit form).
- `layout_builder_add_block` / `layout_builder_update_block` (when the placed block is a normal
  plugin, not `inline_block`).

```php
/**
 * Implements hook_block_plugin_form_alter().
 */
function my_module_block_plugin_form_alter(array &$form, \Drupal\Core\Form\FormStateInterface &$form_state, string $plugin) {
  if ($plugin === 'webform_block') {
    $form['settings']['redirect']['#default_value'] = TRUE;
    $form['settings']['redirect']['#disabled'] = TRUE;
  }
}
```

## `hook_block_type_form_alter(&$form, &$form_state, $block_type)`

Fires for **custom content block** forms — the `block_content` and `inline_block` plugins,
including inline blocks placed via Layout Builder. `$block_type` is the content-block **bundle**
machine name (e.g. `basic`, `accordion`).

Dispatched for these render contexts:
- `block_content_<type>_form` / `block_content_<type>_edit_form` (Block Content forms).
- `layout_builder_add_block` / `layout_builder_update_block` where the plugin is `inline_block`
  (handled via an added `#process` callback, because the inline block form is built by a
  process function).

```php
/**
 * Implements hook_block_type_form_alter().
 */
function my_module_block_type_form_alter(array &$form, \Drupal\Core\Form\FormStateInterface &$form_state, string $block_type) {
  if ($block_type === 'accordion') {
    $form['field_example']['widget'][0]['value']['#default_value'] = 'A better default value';
  }
}
```

## Which hook do I use?

| Block being edited | Hook | Third arg |
|---|---|---|
| A block **plugin** (system, views block, custom plugin, webform block, …) | `hook_block_plugin_form_alter()` | plugin id |
| A **content block** (`block_content`) or **inline block** (`inline_block`), anywhere incl. Layout Builder | `hook_block_type_form_alter()` | bundle machine name |

Note `hook_block_plugin_form_alter()` explicitly **returns early** for the `block_content` and
`inline_block` plugin ids — those always go through `hook_block_type_form_alter()`.

## How dispatch works (for debugging)

`block_form_alter_form_alter()` inspects `$form_id`:
- `block_form` → gets the block entity's plugin id → `_..._block_plugin_form_alter_invoke()`.
- matches `block_content_(.*)_edit_form` / `block_content_(.*)_form` → bundle →
  `_..._block_type_form_alter_invoke()`.
- `layout_builder_add_block` / `layout_builder_update_block` → reads the component
  configuration's `id`; if `inline_block`, adds a `#process` callback that later calls the
  block_type invoke with the inline block's bundle; otherwise calls the block_plugin invoke.

Both invoke helpers call `\Drupal::moduleHandler()->invokeAll()` with the form, form_state and
the plugin/bundle passed by reference. Remember to `drush cr` after adding your implementation
so the hook is discovered.
