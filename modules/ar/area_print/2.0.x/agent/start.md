<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Area Print (area_print) — agent index

Adds a **Print button/link that sends one page region to the print dialog** (via JavaScript)
instead of printing the whole document. Ships a render element, a placeable block, and a helper
function. No routes, no permissions, no services, no dependencies beyond core.
Core requirement `^9 || ^10 || ^11`. Newest release on 2.0.x is **2.0.0-beta4 (beta; no stable exists)**.

What you'd do:
- **Place a configurable Print block (target selector + link/button)** → [blocks/print-area.md](blocks/print-area.md)
- **Add the print control in code (render element `print_area_button` / `area_print()` helper)** → [api/render-element.md](api/render-element.md)

Key facts:
- Render element: `#type => 'print_area_button'` — class `Drupal\area_print\Element\PrintButton`
  (annotation `@RenderElement("print_area_button")`). Properties: `#css_selector` (default `main#main`),
  `#as_link` (FALSE = button, TRUE = link), `#label` (default `t('Print')`).
- Block plugin id `print_area` — class `Drupal\area_print\Plugin\Block\PrintArea`, admin_label "Print area",
  category "System". Per-instance settings: `css_selector`, `type` (`link`/`button`).
- Helper: `area_print(array $options = [])` in `area_print.module` returns the render array.
- Library: `area_print/area_print_js` (`area_print.js`, depends on `core/drupalSettings`).
- Config schema: `block.settings.print_area` → keys `css_selector`, `type`.
- Update hook: `area_print_update_10000()` migrates legacy block setting `css_id` → `css_selector`.
- A `@media print` stylesheet still governs how the selected content looks on paper; this module
  only decides *what* is sent to the dialog. Behaviour varies across browsers — test in the ones
  the audience uses.
