<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Count on Scroll is a field formatter for integer fields that animates the value counting up from zero to its stored number as the element scrolls into the viewport.

---

Count on Scroll adds one field formatter plugin (`count_on_scroll_formatter`) that applies to core
**integer** fields. When the field scrolls into view, its number "ticks up" from zero to the stored
value over a configurable duration — the familiar animated-statistics effect used on marketing and
KPI pages. It is a pure display feature in the *User interface* package: the stored field value is
never changed, and the formatter has no routes, permissions, services, or external dependencies. The
only configurable option is the animation `duration` (milliseconds, default `6000`), set per view
display where the formatter is selected. It reaches its effect by wrapping the rendered number in a
`<span class="counter" data-count="…">`, emptying the visible markup to `0`, attaching a small jQuery
behavior (`js/count_on_scroll.js`) and passing the duration through `drupalSettings`. The behavior
listens on `scroll`/`resize`/`load`, detects when each `.counter` enters the viewport, and animates
`data-count` up with jQuery `.animate()` (swing easing, `toLocaleString('en')` grouping).

---

- Animate an integer field counting up from zero when it scrolls into view.
- Add an "animated statistics" effect to number fields (e.g. "1,240 customers").
- Highlight KPI or metric numbers on a landing or about page.
- Draw attention to a downloads/users/projects counter as the visitor scrolls to it.
- Select the "Count on Scroll" formatter on an integer field's Manage display.
- Set a custom animation duration (in milliseconds) per view display.
- Keep the default 6000 ms (6 second) count-up for a slow, deliberate reveal.
- Use a short duration for a snappier tick-up on above-the-fold numbers.
- Apply the effect only on a specific view mode (e.g. teaser vs. full) via Manage display.
- Render grouped thousands ("1,240") automatically as the number animates.
- Show the same stat as a plain number in one view mode and animated in another.
- Add motion to a stats row built from several integer fields on one entity.
- Trigger the count-up again each time the number re-enters the viewport range.
- Present figures on a node, media entity, taxonomy term, or user with the formatter.
- Combine with layout builder / block placement so counters animate within a section.
- Provide a lightweight, dependency-free counter (only core drupalSettings + jQuery).
- Preserve the underlying stored integer for Views, exports, and other formatters.
- Avoid custom JS by using a ready-made scroll-triggered counter formatter.
- Configure the effect entirely through config (`core.entity_view_display.*`) with Drush.
- Emphasize survey results, funding totals, or membership counts visually.
