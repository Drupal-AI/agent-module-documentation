# Configure a Block field

No site-wide settings page — everything is per field, via the standard Field UI
(Manage fields / form display / display) on any fieldable entity.

## Add the field
1. **Manage fields → Add field → Block field** (`block_field` field type,
   category "Reference").
2. On the **field settings** form (`BlockFieldItem::fieldSettingsForm`) choose a
   **Selection method** (a `BlockFieldSelection` plugin):
   - **Blocks** (`blocks`, default) — a tableselect whitelist of specific block plugin IDs.
   - **Categories** (`categories`) — allow all blocks in the chosen categories.
   Use the "Change selection" button to switch handler and reveal its settings
   (AJAX-driven `selection_settings`).

Field settings config (`field.field.*`):
```yaml
settings:
  selection: blocks
  selection_settings:
    plugin_ids: ['system_powered_by_block', 'views_block:...']
```

## Widget
`block_field_default` (`Manage form display`): editor selects a block from the allowed
list, then fills the block's own configuration form (label + block-specific settings).

## Formatters (`Manage display`)
- `block_field` — builds and renders the selected block instance.
- `block_field_label` — outputs only the block's admin label.

## Stored value
Each field item stores `plugin_id` (main property) plus a `settings` array (the block
configuration). `BlockFieldItem::getBlock()` returns the instantiated block plugin.
