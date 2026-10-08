<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Show readers the estimated remaining reading time on nodes with a scroll-driven gauge.

---

ReadRemaining integrates the aerolab/readremaining.js library to display an estimated remaining-reading-time indicator (a small gauge) on node pages, so visitors can see how much of an article is left — a TL;DR-style aid that makes long content feel more approachable. An admin form at `/admin/config/system/readremaining` selects which content types the gauge appears on, picks a dark or light look, and tunes the JavaScript behavior (DOM selector to measure, min/max time thresholds, show delay, insert position, time-format string, top/bottom offsets, gauge container/wrapper, verbose logging). A `page_attachments` hook loads the library and passes the settings via `drupalSettings` only on nodes of the configured types. The bundled JS library (aerolab/readremaining) must be installed into `/libraries/readremaining` via Composer. This 2.3.x branch requires Drupal 11 or 12 (the 2.2.x branch supported Drupal 10/11). One permission, `administer readremaining`, gates the settings form.

---

- Show the estimated remaining reading time on long articles.
- Display a scroll-driven reading-progress gauge on node pages.
- Make lengthy content feel more approachable (a TL;DR aid).
- Limit the indicator to selected content types only.
- Change the DOM selector the reading time is calculated on (e.g. `body`, `.my-wrapper`, `#content`).
- Switch the gauge between a dark and a light look.
- Delay the gauge's appearance until after a set number of milliseconds.
- Show the gauge immediately on page load instead of waiting for a scroll.
- Customize the time-format string (replacing `%m` and `%s` with minutes and seconds).
- Only show the time when it falls above a minimum threshold in seconds.
- Only show the time when it falls below a maximum threshold in seconds.
- Choose whether the gauge is prepended or appended to its container.
- Append the gauge into a specific container element.
- Scope the gauge's visibility to a wrapper element.
- Apply a top offset for designs that need the gauge to start lower.
- Apply a bottom offset between the box and the element bottom.
- Enable verbose console logging for testing the indicator.
- Restrict who can configure ReadRemaining with a dedicated permission.
- Run on Drupal 11 or Drupal 12.
- Read the module README from the admin help page.
