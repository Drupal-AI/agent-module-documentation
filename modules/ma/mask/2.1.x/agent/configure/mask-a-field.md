<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mask a field (Manage form display)

Masking is applied **per field, per form mode** on a bundle's *Manage form display*, on
widgets that Mask supports.

## Supported widgets

Declared in `mask.mask_field_widgets.yml`:

- `string_textfield` — the core **Text field** widget (used by `string` fields).
- `telephone_default` — the core **Telephone** widget (`telephone` fields).

Other modules can add widgets by shipping `<module>.mask_field_widgets.yml`
(see [../plugins/mask-field-widget.md](../plugins/mask-field-widget.md)). If a widget is not
supported, no "Mask settings" appear on its cog.

## Where the setting is stored

Config entity `core.entity_form_display.<entity_type>.<bundle>.<form_mode>`:

```yaml
content:
  <field_name>:
    type: string_textfield        # or telephone_default / a registered widget
    third_party_settings:
      mask:
        value: '(00) 0000-0000'   # the mask itself (empty = masking off)
        reverse: false
        clearifnotmatch: false
        selectonfocus: false
```

`value` is the mask string written with the translation symbols (see
[settings.md](settings.md)); the module only applies a mask when `value` is a non-empty string.

## Options

| Key | Meaning |
|---|---|
| `value` | the mask pattern, e.g. `00/00/0000`, `(00) 0000-0000`, `AAA-000` |
| `reverse` | apply the mask right-to-left (money/decimals) |
| `clearifnotmatch` | empty the field on blur if the mask is incomplete |
| `selectonfocus` | select the whole value when the field gains focus |

## Via the UI

1. Go to e.g. `/admin/structure/types/manage/article/form-display`.
2. Click the gear/cog on a Text field or Telephone field row.
3. In **Mask settings**, enter the **Mask** (e.g. `00/00/0000`); tick Reverse / Clear if not
   match / Select on focus as needed. The *Available patterns* details lists the symbols.
4. **Update**, then **Save**. The widget summary then shows `Mask: <value>`.

## Via drush php:eval (scriptable)

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$c = $fd->getComponent('field_phone');       // must be a supported widget
$c['third_party_settings']['mask'] = [
  'value' => '(00) 0000-0000', 'reverse' => FALSE,
  'clearifnotmatch' => FALSE, 'selectonfocus' => FALSE,
];
$fd->setComponent('field_phone', $c)->save();
```

Read it back: `drush cget core.entity_form_display.node.article.default content.field_phone`.

## Important limitation

The mask is enforced by JavaScript in the browser only. It improves data-entry UX but does
**not** validate the submitted value server-side — a client without JS (or a direct POST) can
still submit an unmasked value. Add real field validation if the format must be guaranteed.
