# Block Class — service & render path

Service `block_class.helper` = `Drupal\block_class\Service\BlockClassHelperService`
(args: `@config.factory`, `@current_user`, `@entity_type.manager`). It holds all the
logic the module's hooks delegate to; you rarely call it directly.

How stored values reach markup:
- `hook_form_block_form_alter()` → `blockClassFormAlter()` adds the class / ID /
  attribute fields to the block config form (+ `blockClassFormValidate()` validation).
- `hook_block_presave()` → `blockClassPreSave()` persists the entered values into the
  block's third-party settings / config.
- `hook_preprocess_block()` → `blockClassPreprocessBlock()` applies them at render:
  - `addClassesOnBlock()` merges classes into `$variables['attributes']['class']`.
  - `addAttributesOnBlock()` adds arbitrary HTML attributes.
  - `updateBlockId()` replaces the wrapper `id` when ID replacement is enabled.

Notes:
- There is no dedicated public API for other modules; behavior is driven entirely by
  block config + the preprocess hook. To set classes programmatically, set the block's
  stored block_class settings on the block config entity and resave.
- No plugin types, no hooks for others to implement, no Drush commands.
