<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block Button Modal — how it works & configuration

No install-time config, no settings form. Enable the module (`drush en block_button_modal`; requires
core `block`). All configuration is a single per-block checkbox.

## Enabling modal display on a block

`block_button_modal_form_block_form_alter()` (`block_button_modal.module`) alters the block config
form (`block_form`) and adds:

- `$form['third_party_settings']['block_button_modal']['enabled']` — a `#type => checkbox`,
  title *"Show block as modal dialog"*, `#default_value` from
  `$block->getThirdPartySetting('block_button_modal', 'enabled', FALSE)`.

The block edit UI reaches this on any placed block (*Structure → Block layout → Configure*). The
value is stored as a third-party setting on the `block` config entity. Schema
(`config/schema/block_button_modal.schema.yml`):

```
block.block.*.third_party.block_button_modal:
  type: mapping
  mapping:
    enabled: { type: boolean }
```

## Render-time swap

`block_button_modal_block_view_alter(&$build, $entity, $display)` implements
`hook_ENTITY_TYPE_view_alter` for blocks. It returns early unless the block is a
`ThirdPartySettingsInterface` with `enabled` TRUE (or, for the non-entity path, unless
`$build['#configuration']['third_party_settings']['block_button_modal']['enabled']` is truthy). When
enabled it sets:

- `$build['#theme'] = 'block_button_modal_block'`
- `$build['#block_label'] = $build['#configuration']['label']`

`hook_theme()` registers `block_button_modal_block` (render element `elements`).
`template_preprocess_block_button_modal_block()` calls core `template_preprocess_block()`, builds a
unique container id `block-button-modal-block-block-<block-id>`, attaches library
`block_button_modal/block_button_modal_block`, and creates the button render array:

```
'#type' => 'button', '#button_type' => 'block_button_modal',
'#value' => <block label>,
'#attributes' => ['type' => 'button', 'data-block-button-modal-title' => <block label>],
```

Template `templates/block-button-modal-block.html.twig` outputs
`<div class="block-button-modal-block-wrapper">` containing the button, then the normal block
markup (`{{ content }}`) inside `<div id="{{ block_button_modal_block_id }}">`. Twig autoescaping
applies to `label`; the button `#value` and the `data-block-button-modal-title` attribute are
rendered through core's render/attribute escaping.

## Client-side behavior

`js/block_button_modal_block.js` — `Drupal.behaviors.block_button_modal_block` finds each
`.block-button-modal-block-wrapper`, its `button`/`input[type=submit]`, and the inner `.block`
element, then:

```
button.dialog = Drupal.dialog('#' + block.id, { title: <data-...-title>, width: '100%' });
button.addEventListener('click', e => { e.preventDefault(); button.dialog.showModal(); });
```

The dialog operates on the block content **already present in the DOM** — no AJAX, no URL/route is
fetched when the modal opens. Library `block_button_modal_block` depends on `core/drupal` and
`core/drupal.dialog` (+ `css/block_button_modal_block.css` for layout).

## Theming hooks

`hook_theme_suggestions_HOOK_alter` adds suggestions:
- `block_button_modal_block__<block-id>` (the wrapper template)
- for the button `input`: `input__block_button_modal` and
  `input__block_button_modal_block_<block-id>` (only when `#button_type === 'block_button_modal'`).

## Surface summary

No routes (`*.routing.yml` absent), no `*.permissions.yml`, no `*.services.yml`, no Drush commands,
no `src/` classes, no update hooks. Everything lives in `block_button_modal.module` (5 hooks + one
preprocess), the Twig template, the JS behavior, the library and the config schema.
