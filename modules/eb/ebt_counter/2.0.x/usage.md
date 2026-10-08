<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Extra Block Types (EBT): Counter provides an `ebt_counter` block content type that renders animated number counters (each an `ebt_counter_item` paragraph) driven by the CountUp.js JavaScript library, with an optional WYSIWYG body.

---

Part of the Extra Block Types family (built on `ebt_core`), this module installs a reusable custom block type whose fields are configured on the block form: a Paragraphs reference (`field_ebt_counter_items`) holds repeatable counter items (number, title, description, icon), and an `ebt_settings` field exposes CountUp.js options plus the EBT design options (margin, padding, border, background, breakpoints). The `ebt_settings_counter` field widget adds counter-specific options: a 2/3/4-column layout (`styles`), start value, decimals, duration, grouping separators, prefix/suffix, easing, and scroll-spy — all serialized into `drupalSettings` and read by `js/countup.js`, which initializes CountUp.js (loaded from `/libraries/count-up.js`) via `core/once` when the counter scrolls into view. The module is display-only: it registers a `hook_theme` template and a field theme suggestion for the counter number, provides one field widget plugin, and ships no routes, permissions, or services beyond an autowired hook class.

Typical setup is to enable the module (which auto-creates the block type, paragraph type, and fields), then add an EBT Counter block through Layout Builder or Block layout, add counter items, and tune the CountUp.js and design options in the block's Settings tab. All output flows through standard block, paragraph, and field theming.

---
- Enable the module to auto-create the `ebt_counter` block type and fields.
- Add an EBT Counter block to a page via Layout Builder.
- Place a counter block in a region through Block layout.
- Show "coffee cups / projects / clients" style animated stats.
- Configure a 2, 3, or 4 column counter layout.
- Set each counter's start value and end number.
- Add a decimal counter (e.g. 4.9 rating) via the decimals option.
- Set animation duration for the count-up effect.
- Add a thousands separator (comma, dot, or dash) to large numbers.
- Add a prefix (e.g. "$") or suffix (e.g. "+", "%") to a counter.
- Add a title and description under each counter number.
- Add an icon to a counter item.
- Add a WYSIWYG intro/body above the counters.
- Apply EBT design options (margin, padding, border) to the block.
- Set a background color or background image style on the block.
- Configure responsive breakpoints inherited from EBT Core.
- Trigger the count-up only when the block scrolls into view (scroll spy).
- Run the count-up animation once per page load.
- Enable or disable easing for smoother large-number animation.
- Reuse the same counter block across multiple pages.
- Override the counter number field template with the supplied suggestion.
- Combine several counter items in one block for a stats row.
- Use it as a standalone block type without other EBT block modules.
