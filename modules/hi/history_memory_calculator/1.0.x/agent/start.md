<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# History Memory Calculator (history_memory_calculator) — agent index

**A block that renders a client-side calculator with memory and timestamped history.**

- **Version:** 1.0.x
- **Core:** `^8 || ^9 || ^10`
- **Dependency:** block
- **Block plugin:** `history_memory_calculator_block` (`Plugin\Block\CalculatorBlock`); one `layout` setting; `getCacheMaxAge()=0`.
- **Library:** `history_memory_calculator.frontend` (jQuery, drupal.ajax, once, drupalSettings) + Twig template.

**Security:** presentation-only block, no routes, forms, permissions, stored data or external calls — the calculator runs entirely in JavaScript. Placement/visibility use core Block access.
