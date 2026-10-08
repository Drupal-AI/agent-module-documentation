<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the block title class

The whole module is `block_title_class.module` (three hooks). There is no admin settings page and
no module config object — the value lives on each block entity as a third-party setting.

## Install / enable

- `drush en block_title_class -y`. Core `block` is the only dependency
  (`core_version_requirement: ^9 || ^10 || ^11`).

## Where the setting appears

`block_title_class_form_block_form_alter()` implements `hook_form_FORM_ID_alter()` for the block
configuration form (`form_id` `block_form`). It bails unless `$form_state->getFormObject()` is an
`EntityFormInterface`, then adds:

- A `details` element `title_class` (`#title` "Title Class", `#open` TRUE, `#weight` 0).
- Inside it, `third_party_settings[block_title_class][title_class]`, a `#type => 'select'` with
  `#options` `['_none' => None, 'h1' => 'h1', … 'h6' => 'h6']`, `#default_value` from
  `$block->getThirdPartySetting('block_title_class', 'title_class')`. The select carries the CSS
  class `block-title-class-title-class`. `#tree` is set on the `third_party_settings` wrapper so the
  value nests correctly.

Reach it at **Structure → Block layout → Configure** on any placed block
(`/admin/structure/block/manage/<block>`). Editing is gated by core's own block-administration
access (`administer blocks`); the module adds no route and no permission of its own.

## Save path

- `block_title_class_form_block_form_validate()` (registered as a `#validate` handler) reads
  `title_class[third_party_settings]`, `array_filter`s the `block_title_class` sub-array to drop the
  empty/`_none`-cleared value, merges it into the form's main `third_party_settings` value, then
  `unsetValue('title_class')` so only the canonical third-party structure is saved.
- `block_title_class_block_presave()` (`hook_ENTITY_TYPE_presave` for `block`) unsets the
  third-party setting when it is empty, otherwise re-sets it — normalizing storage.

## Storage & schema

- Stored as a block third-party setting: `block.block.<id>` → `third_party_settings.block_title_class.title_class`.
- Schema (`config/schema/block_title_class.schema.yml`):

  ```yaml
  block.block.*.third_party.block_title_class:
    type: mapping
    label: 'Block title class third party settings'
    mapping:
      title_class:
        type: string
        label: 'Additional class for the block title'
  ```

Config-export snippet for a block using it:

```yaml
third_party_settings:
  block_title_class:
    title_class: h2
```

## Render behavior

`block_title_class_preprocess_block()` (`hook_preprocess_block`) runs on every block render:

1. Skips when `$variables['elements']['#id']` is empty (e.g. Page Manager blocks with no id).
2. Loads the block entity via the `block` storage; skips if it does not load.
3. Reads `title_class`; when non-empty and not `_none`, appends it to
   `$variables['title_attributes']['class'][]`.

The title element must render `{{ title_attributes }}` for the class to appear (README shows
`<h2{{ title_attributes }}>{{ label }}</h2>`). Values are drawn from the fixed h1-h6 option list and
emitted through Drupal's title-attributes rendering.
