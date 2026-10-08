<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `micon_link` widget & formatter

Both plugins target the core **`link`** field type. Configure them on the field's
*Manage form display* (widget) and *Manage display* (formatter) — there is no admin settings page.

## Widget `micon_link` (extends `LinkWidget`)
Adds a `#type => 'micon'` picker to each link item. The icon is stored on the link value at
`options.attributes.data-icon`; position at `options.attributes.data-icon-position`.

Settings (`field.widget.settings.micon_link`, defaults from `MiconLinkWidgetTrait::prependDefaultSettings()`):

| setting | type | meaning |
|---|---|---|
| `packages` | list of micon ids | packages offered in the picker (empty = all) |
| `icon` | string | default icon prefilled on new items |
| `position` | bool | if TRUE, expose a Before/After/Icon only select (`data-icon-position`) |
| `target` | bool | if TRUE, expose an "open in new window" checkbox (`target=_blank`) |
| `placeholder_url`, `placeholder_title` | string | inherited link placeholders |

## Formatter `micon_link` (extends `LinkFormatter`)
Renders each link through `MiconIconize` so the icon shows with the text. Settings
(`field.formatter.settings.micon_link`) add to the core Link formatter settings:

| setting | meaning |
|---|---|
| `title` | override link text (token-aware, `[node:…]` etc.); used when the item has none |
| `icon` | fallback icon when the link value has no `data-icon` |
| `position` | fallback icon position (`before`/`after`/`icon_only`) |
| `text_only` | render icon+text as plain `#markup` (no anchor) |

Per item the formatter reads `data-icon` / `data-icon-position` from the link's
`options.attributes` and falls back to the formatter `icon`/`position` settings.

## Set the widget in code
```php
$fd = \Drupal::service('entity_display.repository')->getFormDisplay('node', 'article', 'default');
$fd->setComponent('field_my_link', [
  'type' => 'micon_link',
  'settings' => ['packages' => ['fa' => 'fa'], 'icon' => 'fa-link', 'position' => TRUE, 'target' => FALSE],
])->save();
```
The stored icon then lives on each saved link item as `options.attributes.data-icon`.
