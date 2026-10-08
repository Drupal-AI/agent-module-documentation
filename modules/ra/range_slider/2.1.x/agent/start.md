<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Range Slider — agent index

Wraps rangeslider.js around core's HTML5 range input. Provides a `range_slider` form element, a
numeric **field widget** (integer/decimal/float), and a Webform element. No settings form, no
permissions, no Drush, no configure route.

- **Use the field widget on a numeric field + its settings (orientation, output)** →
  [configure/widget.md](configure/widget.md)
- **Use the `range_slider` render/form element directly; Webform element; JS library** →
  [api/element.md](api/element.md)

Key facts:
- Field widget id: `range_slider`; works on core `integer`, `decimal`, `float` fields.
- Widget settings schema: `field.widget.settings.range_slider` → `orientation`
  (`horizontal`|`vertical`) and `output` (`_none_`|`below`|`above`|`left`|`right`).
- Form element type: `range_slider` (class `Drupal\range_slider\Element\RangeSlider` extends core `Range`).
- Library `range_slider/element.rangeslider` loads rangeslider.js 2.3.2 from a CDN.
