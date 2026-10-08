<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Micon Linkit Attributes — agent index

Thin glue: one field **widget** `micon_linkit_attributes` (label "Linkit (with icon and
attributes)") for the core `link` field type. Extends `linkit_attributes`'
`LinkitWithAttributesWidget` + `micon_link`'s `MiconLinkWidgetTrait`. Requires contrib
**linkit**, **link_attributes** (`linkit_attributes`), and **micon_link**. No settings form,
no `configure` route, no formatter of its own.

Key facts (grounded in `micon_linkit_attributes/src/Plugin/Field/FieldWidget/MiconLinkitAttributesWidget.php`):
- Widget id **`micon_linkit_attributes`**; select it on the link field's *Manage form display*.
- Icon storage identical to `micon_link` (`options.attributes.data-icon`); reuses the
  `packages`/`icon`/`position` settings but **drops `target`** (linkit_attributes handles it).
  See [../../../micon_link/2.1.x/agent/configure/widget-formatter.md](../../../micon_link/2.1.x/agent/configure/widget-formatter.md).
- Render with the core Link or `micon_link` formatter.

Set the widget in code:
```php
$fd = \Drupal::service('entity_display.repository')->getFormDisplay('node','article','default');
$fd->setComponent('field_my_link', ['type' => 'micon_linkit_attributes'])->save();
```
