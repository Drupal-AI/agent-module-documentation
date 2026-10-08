# Configure — Quick Add settings

Settings form: `Drupal\layout_builder_quick_add\Form\QuickAddConfigForm`
(`ConfigFormBase`, form id `quick_add_config_form`).
Route `layout_builder_quick_add.quick_add_config_form` → `/admin/config/content/layout_builder_quick_add`
(requires permission `administer layout_builder_quick_add configuration`; also a menu link under
Configuration › Content authoring). Editable config: `layout_builder_quick_add.settings`.

The form is organised into vertical tabs: General, Enabled blocks, Order, Screenshots, Preview.

## Config keys (`layout_builder_quick_add.settings`)

| Key | Type | Default (config/install) | Meaning |
|-----|------|--------------------------|---------|
| `theme` | string | `default` | CSS theme for the listing: `default`, `none`, `claro`, `gin`. Selects the `layout_builder_quick_add/<theme>` library. `none` attaches no CSS. |
| `display_description` | int (0/1) | `1` | Show each block type's description on the item. |
| `multiple_view_mode` | int (0/1) | `0` | Show a message when a block type has more than one enabled view mode. |
| `multiple_view_mode_message` | string | `This block has multiple view modes.` | The message text used when `multiple_view_mode` is on. |
| `inline_blocks` | array | `[]` | Checkbox map of `block_content_type` id → enabled flag (from the Enabled blocks tab). |
| `blocks_order` | array | `[]` | Ordered map `block_content_type id → ['weight' => n]`. This is what actually drives which items render, and in what order (see runtime note). |
| `screenshot:<block_content_type_id>` | array | (unset) | Managed-file value (array of file ids) for a per-block-type screenshot shown in the tooltip. One dynamic key per block type. |

No `config/schema/*` is shipped, so these keys are schema-less.

## Runtime: which blocks are shown

`LayoutBuilderQuickAddHelper::getQuickAddEnabledBlocks()` reads `blocks_order` (NOT `inline_blocks`
directly):
- It iterates the keys of `blocks_order` in order and includes each that still exists as a
  `block_content_type`.
- If `blocks_order` is empty (typical right after install, before the form is saved), it shows
  ALL `block_content_type` bundles.

On save, `submitForm()` writes `inline_blocks` (the checkbox values), and rebuilds `blocks_order`
from the Order tab's tabledrag rows plus any newly-enabled block that had no weight yet (added with
weight 0). Screenshot files selected on the form are marked permanent (`File::setPermanent()`) and
their ids stored under the matching `screenshot:*` key.

## Set via Drush / PHP

```bash
# Pick the Gin CSS theme for the listing and turn on descriptions.
drush config:set layout_builder_quick_add.settings theme gin -y
drush config:set layout_builder_quick_add.settings display_description 1 -y
```

```php
$config = \Drupal::configFactory()->getEditable('layout_builder_quick_add.settings');
// Show only two block types, in this order (weights are what the helper reads).
$config->set('blocks_order', [
  'hero'  => ['weight' => 0],
  'promo' => ['weight' => 1],
]);
$config->set('inline_blocks', ['hero' => 'hero', 'promo' => 'promo']);
$config->set('theme', 'claro');
$config->save();
```

Note: at install, `hook_install` presets `theme` to `gin` when the site's admin theme is `gin`;
otherwise `default` from config/install.
