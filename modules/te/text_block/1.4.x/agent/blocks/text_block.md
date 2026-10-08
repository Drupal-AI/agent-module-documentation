<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block: `text_block`

The whole module is this one block plugin. Class
`Drupal\text_block\Plugin\Block\TextBlock` extends `BlockBase` and implements
`ContainerFactoryPluginInterface` (injects `module_handler`).

```
@Block(
  id = "text_block",
  admin_label = @Translation("Text Block"),
  category = @Translation("Text Block")
)
```

Place it like any block at `/admin/structure/block` (theme regions) or add it as a Layout Builder
block. Requires the `administer blocks` permission to place/configure — there is no dedicated
permission of its own.

## Configuration (config schema)

`config/schema/text_block.schema.yml`:

| Key            | Type          | Notes                                                        |
| -------------- | ------------- | ----------------------------------------------------------- |
| `text`         | `text_format` | Composite; stores `text.value` and `text.format`.           |
| `text.value`   | string        | The body markup entered in the block form.                  |
| `text.format`  | string        | Filter format machine name, e.g. `basic_html`; may be NULL. |

The schema id is `block.settings.text_block` (extends core `block_settings`), so the value lives
inside the block entity's `settings.text` in `block.block.<id>` config.

## Form and defaults

- `defaultConfiguration()` — default `text` is `['value' => NULL, 'format' => NULL]`. If `filter`
  is enabled and the current user has any usable formats (`filter_formats($current_user)`), the
  default format is `filter_default_format($current_user)`.
- `blockForm()` — adds `text` as a `#required` `textarea`. If `filter` is enabled it upgrades the
  element to `#type => 'text_format'` and seeds `#format` from the stored format. Using
  `text_format` means the editor can only pick from filter formats they are permitted to use.
- `blockSubmit()` — saves `$form_state->getValue('text')` into `$this->configuration['text']`.
  If the value came back as a bare string (no `filter` module), it is wrapped as
  `['value' => $text, 'format' => NULL]`.

## How the text renders (`build()`)

```php
$value  = $settings['text']['value'] ?? '';
$format = $settings['text']['format'] ?? NULL;
if (!isset($format) || !$moduleHandler->moduleExists('filter')) {
  return ['#markup' => $value];
}
return ['#type' => 'processed_text', '#text' => $value, '#format' => $format];
```

- **Format stored + `filter` enabled** → `#type => processed_text`, which runs the value through
  `check_markup()` with the stored format (the format's filter pipeline applies).
- **No format, or `filter` disabled** → `#markup`, which core's renderer emits through
  `Xss::filterAdmin()` (the broad admin tag allowlist; script tags, `on*` handlers and `style`
  attributes are dropped). The kernel test `TextBlockTest` asserts, for example, that a `<script>`
  payload with `format = NULL` renders as `alert("Must not happen");`.

## Setting the text without the UI

The block is ordinary config, so write to `block.block.<id>`:

```php
$block = \Drupal::entityTypeManager()->getStorage('block')->load('mysite_notice');
$settings = $block->get('settings');
$settings['text'] = ['value' => '<p>Site notice.</p>', 'format' => 'basic_html'];
$block->set('settings', $settings);
$block->save();
```

Or edit the YAML directly and `drush cim`:

```yaml
# block.block.mysite_notice.yml
settings:
  id: text_block
  provider: text_block
  text:
    value: '<p>Site notice.</p>'
    format: basic_html
```

## Config portability

`calculateDependencies()` adds `module: filter` when `filter` is on, and — if a format is stored —
loads the `filter_format` entity and records a dependency on it
(`$config->getConfigDependencyKey()` / `getConfigDependencyName()`). So an exported Text Block
declares its filter-format dependency and imports cleanly on another environment. Because the text
is configuration, a `drush cim` overwrites any change made through the block UI on that environment.
