<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CountUp Formatter is a field formatter that renders integer, decimal and float fields as an animated number that counts up from a start value to the field value when the element scrolls into the viewport, using the countUp.js library.

---

CountUp Formatter provides a single Field Formatter plugin (`CountUpFormatter`, id `countup_formatter_countupformatter`, label "CountUp") that extends core's `NumericFormatterBase`. Selected per view-display on Manage display for integer / decimal / float fields, it emits the formatted number with `data-*` attributes (start value, end value, duration, prefix, suffix, decimal marker, grouping separator, decimal places) plus a `countup-formatter` class, and attaches `js/countup.js`. That behavior watches DOMContentLoaded / load / resize / scroll (debounced), and when a target scrolls fully into view it instantiates countUp.js to animate the value. The countUp.js library itself is NOT bundled — you must install `inorganik/countup-js` (2.4.2+) into `/libraries/countup.js/dist/countUp.umd.js` (manually or via composer-merge-plugin), or the animation silently does nothing. No permissions, routes, services, hooks, config schema or submodules. All formatter/field settings are set by administrators on Manage display.

---

- Animate an integer field counting up as it scrolls into view.
- Turn a "customers served" number into a scroll-triggered stat.
- Show a decimal metric (e.g. rating 4.7) animating on an impact section.
- Animate a float field with configurable decimal places (`scale`, 0–10).
- Count up from a non-zero start value via the `start_val` setting.
- Set the animation length in seconds with the `duration` setting.
- Choose a decimal marker (point or comma) with `decimal_separator`.
- Group thousands by setting a `thousand_separator` (also drives `data-useGrouping`).
- Prefix a value with a currency symbol such as `$` via the `prefix` setting.
- Suffix a value with a unit such as ` m` or ` kb/s` via the `suffix` setting.
- Render a homepage statistics band where each figure animates in on scroll.
- Apply the effect per bundle and per view mode (teaser vs full) independently.
- Format numbers in a Views field by choosing the CountUp formatter on the field.
- Configure everything through Manage display or exported view-display config.
- Install the countUp.js library once and reuse it across many fields.
- Fall back gracefully: if the library is missing, the plain formatted number shows.
- Keep numeric grouping/decimals consistent with core's numeric formatter settings.
- Use `core/drupal.debounce` throttling so scroll handling stays cheap.
- Trigger the count only when the element is fully within the viewport.
- Ensure a number is only animated once (`countup-processed` guard class).
- Present KPI dashboards or landing pages with lively animated figures.
- Confirm the effect suits accessibility (reduced-motion) expectations before use.
