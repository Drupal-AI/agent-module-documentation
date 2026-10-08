<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block: Custom Markup

Single block plugin. Class `Drupal\custom_markup_block\Plugin\Block\CustomMarkup`
(`src/Plugin/Block/CustomMarkup.php`), extends `Drupal\Core\Block\BlockBase`.

Annotation:

```
@Block(
  id = "custom_markup",
  admin_label = @Translation("Custom Markup"),
  category = @Translation("Custom Blocks")
)
```

The block content is held in the block instance configuration, not in a `block_content`
entity. Placing it therefore only creates config (a `block.block.*` config entity), which
deploys with `drush cex`/`cim`.

## Configuration keys

Config schema key `block.settings.custom_markup` (`config/schema/custom_markup_block.schema.yml`):

| Key | Type | Notes |
|-----|------|-------|
| `markup` | `text_format` | The block body. |
| `markup.value` | string | Raw entered text/markup. |
| `markup.format` | string (filter format id) | Text format applied on render. |

`defaultConfiguration()` returns `markup => ['format' => 'full_html', 'value' => '']` plus the
`BlockBase` defaults.

## Form and rendering

- `blockForm()` builds one element: `markup` of `#type => 'text_format'`, seeded with the stored
  `#format` and `#default_value`. The `text_format` element restricts the format dropdown to the
  formats the editing user is permitted to use.
- `blockSubmit()` stores the whole submitted value: `$this->configuration['markup'] =
  $form_state->getValue('markup');` (an array with `value` and `format`).
- `build()` returns, only when `markup.value` is non-empty:

```php
[
  '#type'   => 'processed_text',
  '#text'   => $this->configuration['markup']['value'],
  '#format' => $this->configuration['markup']['format'],
];
```

`processed_text` runs the stored value through the selected text format's filter pipeline, so
what renders is exactly what that format's filters allow. An empty value renders nothing.

## Who can place/edit it

The module declares no permissions. Placing and editing the block goes through the core block UI
(`Structure › Block layout`) gated by the core `administer blocks` permission. The available
text formats are further limited by the user's filter-format access (e.g. `use the full_html
text format`).

## Set it via config / PHP

Place through the UI (`Structure › Block layout › Place block › Custom Markup`), or set the config
programmatically, e.g.:

```php
\Drupal::service('plugin.manager.block')
  ->createInstance('custom_markup', [
    'id' => 'custom_markup_footer',
    'label' => 'Footer note',
    'markup' => ['value' => '<p>© Acme</p>', 'format' => 'full_html'],
  ]);
```

In practice you place it via the block UI and then export with `drush cex`; the resulting
`block.block.<id>.yml` carries `settings.markup.value` and `settings.markup.format`.

## Optional tokens

`composer.json` suggests `drupal/token_filter`. If that module is enabled and its filter is added
to the chosen text format, token placeholders in `markup.value` are replaced as part of the same
filter pipeline. The block itself contains no token logic.
