<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Micon Linkit — agent index

Thin glue: one field **widget** `micon_linkit` (label "Linkit (with icon)") for the core
`link` field type. Extends Linkit's `LinkitWidget` + `micon_link`'s `MiconLinkWidgetTrait`.
Requires contrib **linkit** and **micon_link**. No settings form, no `configure` route,
no formatter of its own.

Key facts (grounded in `micon_linkit/src/Plugin/Field/FieldWidget/MiconLinkitWidget.php`):
- Widget id **`micon_linkit`**; select it on the link field's *Manage form display*.
- Icon storage & widget settings are identical to `micon_link`
  (icon in `options.attributes.data-icon`; settings `packages`/`icon`/`position`/`target`
  plus Linkit's `linkit_profile`). See
  [../../../micon_link/2.1.x/agent/configure/widget-formatter.md](../../../micon_link/2.1.x/agent/configure/widget-formatter.md).
- Render with the core Link or `micon_link` formatter.

Set the widget in code:
```php
$fd = \Drupal::service('entity_display.repository')->getFormDisplay('node','article','default');
$fd->setComponent('field_my_link', ['type' => 'micon_linkit'])->save();
```
