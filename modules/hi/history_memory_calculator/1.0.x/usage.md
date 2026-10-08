<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
History Memory Calculator provides a block that renders an interactive calculator with memory and calculation-history support.
---
The module exposes a single block plugin, `history_memory_calculator_block` (`CalculatorBlock`), that a site builder places in any region. The block renders a Twig template and attaches a JS/CSS library (jQuery, `core/drupal.ajax`, `once`, drupalSettings) that implements the calculator UI — basic arithmetic, memory store/recall, a timestamped calculation history with pagination, and clear functions — entirely client-side in the browser. The block has one config setting, a layout selector (currently a single "Layout 1"), and sets `getCacheMaxAge() = 0` so it is not cached.

There is no server route, form submission, stored data, permission or external call — the calculator runs in JavaScript and nothing is persisted server-side. Placement and visibility follow standard core Block module access.

Setup: enable the module and place the "History Memory Calculator Block" via Block layout (or a block-placement config).
---
- Place an interactive calculator block in any theme region.
- Offer site visitors basic arithmetic (add, subtract, multiply, divide, percentage).
- Support decimal / floating-point calculations.
- Store and recall values with the memory function.
- Keep a timestamped history of past calculations.
- Paginate through calculation history.
- Clear the display, memory, or full history.
- Add a calculator to an educational website.
- Provide a price/estimate helper on an e-commerce page.
- Offer a savings/finance calculation aid.
- Choose the calculator layout in the block config.
- Rely on standard core block visibility/access controls.
- Override the calculator styling in a custom theme.
- Add the calculator to a sidebar or footer region.
- Give users a quick on-page calculation tool.
- Use as a demo of a JS-driven block widget.
