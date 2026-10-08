<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EPT Counter adds "EPT Counter" and "EPT Counter Item" paragraph types that display groups of animated count-up numbers with titles, descriptions and optional media icons.

---

EPT Counter is part of the Extra Paragraph Types (EPT) family and builds on `ept_core` and `paragraphs`. Installing it creates two Paragraphs bundles: a container bundle `ept_counter` (with a title, WYSIWYG text, an EPT settings field, and a repeatable reference to items) and an item bundle `ept_counter_item` (an integer number, a title, a description, and a media Image icon). On the front end each item's integer is animated from a start value up to its final value using the bundled CountUp.js library (levmyshkin/count-up.js 2.8). A per-paragraph EPT settings widget (`ept_settings_counter`) exposes the column layout (2, 3 or 4 columns) plus the full CountUp option set — start value, prefix, suffix, decimal places, duration, grouping and separator, easing, and scroll-spy — which are passed to the JavaScript through `drupalSettings`. Because every EPT paragraph carries the shared `ept_core` design options (CSS box spacing, backgrounds, edge-to-edge, container width), counters can be styled and placed without custom theme code.

---

- Show headline "big number" statistics on a landing or about page.
- Display 2, 3 or 4 columns of counters side by side.
- Animate a number counting up from a start value to its final value.
- Add a prefix (for example "$" or "+") in front of the animated number.
- Add a suffix (for example "%", "k" or "M") after the number.
- Show grouped thousands with a comma, dot or dash separator.
- Show decimal places on a counter (for example ratings or averages).
- Control the animation duration in seconds per counter block.
- Enable or disable easing on the count-up animation.
- Start the animation only when the counter scrolls into view (scroll spy).
- Run the scroll-spy animation once, or every time it re-enters the viewport.
- Delay the scroll-spy animation by a number of milliseconds.
- Attach a media Image icon above each counter item.
- Give each counter a short title and a longer description.
- Add an overall block title with a configurable heading wrapper.
- Include a rich-text (WYSIWYG) intro above the counters.
- Reuse the shared EPT design options for margins, padding, borders and backgrounds.
- Build "coffee cups / projects / clients / awards" style stat rows quickly.
- Place counters inside other layout paragraphs via the Paragraphs field.
- Present metrics for a charity, agency or portfolio site.
- Add a video, image or parallax background behind a counter block via EPT Core.
