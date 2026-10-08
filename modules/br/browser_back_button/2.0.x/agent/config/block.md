<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Browser Back Button — the block, configuration, and wiring

Everything this module does lives in one Block plugin. There is no settings form, route, or
permission of its own.

## Install / enable

- `drush en browser_back_button -y` (no dependencies; core `^8 || ^9 || ^10 || ^11`).
- Go to **Structure → Block Layout** (`/admin/structure/block`), click **Place block**, choose
  *"Browser Back Button Block"* (category *"Browser Back Button Block"*), and assign a region.
  Placing blocks requires the core `administer blocks` permission.

## The block plugin

`src/Plugin/Block/BrowserBackButtonBlock.php` — `class BrowserBackButtonBlock extends BlockBase`:

- Annotation: `id = "browser_back_button_block"`, `admin_label` / `category` both
  *"Browser Back Button Block"*.
- `defaultConfiguration()` → `body` = `['value' => t('Back')]`, `reload_status` = `1`.
- `blockForm()` adds one element `body` of `#type => 'text_format'` (title *"Back Button Text or
  Image"*), defaulting the format to `filter_default_format()` when none is set. `reload_status` is
  **not** rendered in the form.
- `blockSubmit()` saves only `body` (`setConfigurationValue('body', $form_state->getValue('body'))`).
- `build()` computes:
  - `$data['body'] = check_markup($this->configuration['body']['value'], $this->configuration['body']['format'])` — filtered through the admin-chosen text format.
  - `$data['reload_status'] = $this->configuration['reload_status']` (carried but unused downstream).
  - Returns a render array with `#theme => 'browser_back_button_history'`, `#data => $data`,
    `#attached['library'] => ['browser_back_button/browser_back_button.history']`, and
    `#attached['drupalSettings']['browser_back_button']['data'] => $data`.

## Config schema

`config/schema/browser_back_button.schema.yml` defines `block.settings.browser_back_button_block`
(type `block_settings`) with mapping:

- `body` → type `text_format`, label *"Body"*.
- `reload_status` → type `boolean`, label *"Reload Status"*.

These are stored inside the block config entity (`block.block.<id>.settings`), so they travel with
standard config export/import.

## Theme + template

`browser_back_button_theme()` in `browser_back_button.module` registers hook
`browser_back_button_history` with variable `data` and template
`browser-back-button-history`. The template
(`templates/browser-back-button-history.html.twig`) is just:

```twig
<div id="back-button-wrapper">
  {{ data.body }}
</div>
```

Target `#back-button-wrapper` for CSS. Note `{{ data.body }}` is the `check_markup()` result.

## JavaScript behavior

`js/browser_back_button.history.js` (library `browser_back_button/browser_back_button.history`,
deps `core/drupal`, `core/jquery`, `core/once`) registers
`Drupal.behaviors.browser_back_button`. On `attach`, it binds — once, via
`once('back-button-wrapper', '#back-button-wrapper', context)` — a `click` handler that calls
`window.history.back()`. It reads nothing from `drupalSettings`; the attached `drupalSettings`
payload is effectively unused.

## Operating notes / gotchas

- **`reload_status` does nothing.** Despite the module description mentioning "page reload", the
  option is not in the block form, not saved by `blockSubmit()`, and not read by the JS. The click
  only performs `history.back()` — no forced reload.
- The control's appearance/label is whatever HTML you enter in the rich-text `body` (plain text, an
  `<img>`, or an icon). It is rendered through the selected text format's filters.
- Multiple placements each attach their own library and each render a `#back-button-wrapper`; if you
  place several, the duplicate element ID is technically invalid HTML — prefer one placement per
  page/region set.
- `hook_help()` for `help.page.browser_back_button` renders `README.txt`, using the `markdown`
  filter module when enabled, otherwise an escaped `<pre>` block.
