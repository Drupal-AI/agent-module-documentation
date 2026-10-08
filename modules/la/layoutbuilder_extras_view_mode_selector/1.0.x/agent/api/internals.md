# Internals — hooks, service, block plugin

The module is ~200 lines. It has no routes, controllers, forms of its own (only a form alter), events
or drush. Everything runs through two hooks in
`layoutbuilder_extras_view_mode_selector.module`, one service, and one block-plugin subclass.

## Hooks

- **`hook_block_alter(&$definitions)`** (`.module:17`). Iterates every block plugin definition; for
  any id that `str_contains(…, 'inline_block:')`, overwrites `$definition['class']` with
  `Drupal\layoutbuilder_extras_view_mode_selector\Plugin\Block\LayoutBuilderExtrasInlineBlock`. This
  is the real runtime hook: Layout Builder places core `inline_block:<bundle>` derivatives, and this
  swaps their class. Verified at runtime, e.g. `inline_block:basic` resolves to the module's class.
- **`hook_form_block_content_type_edit_form_alter(&$form, $form_state)`** (`.module:36`). Instantiates
  `BlockContentTypeEditForm` and calls `alterForm()` — see
  [../configure/view-modes.md](../configure/view-modes.md).

## Service — `layoutbuilder_extras_view_mode_selector.helper`

`ViewModeSelectorHelper` (`src/ViewModeSelectorHelper.php`), constructed with
`@entity_display.repository`. One method:

```php
public function getViewModesForBundle(string $bundle) {
  return $this->entityDisplayRepository
    ->getViewModeOptionsByBundle('block_content', $bundle);
}
```

Returns `[view_mode_machine_name => human label]` for the `block_content` entity type / given bundle.
Used only by the edit-form alter to list candidate view modes.

## Block plugin — `LayoutBuilderExtrasInlineBlock`

`src/Plugin/Block/LayoutBuilderExtrasInlineBlock.php`. Block id `lb_extras_inline_block`, extends core
`Drupal\layout_builder\Plugin\Block\InlineBlock`, same core `InlineBlockDeriver`, category "Inline
blocks", marked `@internal`. Adds `@renderer` to core's constructor args (the extra service beyond
core InlineBlock's `entity_type.manager`, `entity_display.repository`, `current_user`).

Both plugin-id families exist at runtime — the annotated `lb_extras_inline_block:<bundle>` and the
core `inline_block:<bundle>` (re-classed by the hook). Layout Builder's inline-block flow uses the
core `inline_block:*` ids, so it is the class swap, not the annotation, that takes effect.

### `blockForm()` (`:73`)

1. Calls `parent::blockForm()` to get core's inline-block form (which includes a `view_mode` select).
2. Loads the `BlockContentType` for the block's bundle and reads its third-party setting
   `view_modes` (provider `layoutbuilder_extras_view_mode_selector`).
3. **If there are no settings, returns the core form unchanged.**
4. Otherwise rewrites `$form['view_mode']`: `#weight = -50`, removes `#description`, sets
   `#type = 'radios'`, replaces `#options` via `generateRadioOptions()`, and adds CSS class
   `view-mode-wrapper`.

### `generateRadioOptions()` (`:104`, private)

Walks the original select `#options`; **skips** any key whose stored `view_mode_enabled` is falsy.
For each remaining key it renders an image via the injected `renderer`:

```php
$render = [
  '#theme' => 'image',
  '#uri'   => $settings[$key]['view_mode_icon'],
  '#alt'   => $this->t($settings[$key]['view_mode_icon_alt']),
  '#title' => $settings[$key]['view_mode_machine_name'],
  '#attributes' => ['aria-hidden' => 'true'],
];
$options[$key]  = $this->renderer->render($render);
$options[$key] .= '<span class="visually-hidden">' . $settings[$key]['view_mode_machine_name'] . '</span>';
```

The option label is therefore rendered `<img>` markup plus a visually-hidden machine-name span. The
values here (`view_mode_icon`, `view_mode_icon_alt`, `view_mode_machine_name`) come from the block
type's third-party settings, editable only by users who may administer block content types.

## No config schema at runtime

Third-party settings persist as plain config, but the shipped schema
(`install/schema/…schema.yml`) is not in a Drupal-scanned directory (`config/schema/`) and its top
key carries an extra module-name prefix, so no schema is registered for `view_modes`. Functionally
harmless; relevant only if you run config-schema strictness checks.
