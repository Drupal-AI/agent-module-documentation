<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EPT Countdown adds an "EPT Countdown" Paragraph type that renders an animated FlipDown countdown to a configured target date, part of the Extra Paragraph Types (EPT) family.

---

EPT Countdown ships a single Paragraphs bundle (`ept_countdown`) with a required datetime field (the target date), an optional title and text, and the shared EPT design/settings field. On display a Twig template emits the target date as a Unix timestamp in a `data-date` attribute, and `js/ept_countdown.js` initialises the bundled FlipDown.js widget with the chosen color theme (dark/light), the special style (default or "New Year", which attaches a snow-effect library), and per-unit headings (Days/Hours/Minutes/Seconds). Like every EPT type it inherits `ept_core`'s design options tab — CSS box spacing, borders, background color/image/video, edge-to-edge and container width — so an editor can style the countdown without writing CSS. It requires `ept_core`, `paragraphs`, core `datetime`, and the `levmyshkin/flipdown` front-end library placed in `/libraries/flipdown`. All configuration lives on the Paragraph edit form and is gated by the normal Paragraphs/content-edit permissions; there is no module route, permission, or settings form of its own.

---

- Add an animated countdown to any Paragraphs-enabled entity (node, block, etc.).
- Count down to a product launch or release date.
- Build a sale or promotion "ends in" timer on a landing page.
- Show an event countdown (webinar, conference, concert).
- Create a "coming soon" / pre-launch page timer.
- Count down to a New Year celebration using the built-in "New Year" snow style.
- Add a deadline countdown for registrations or submissions.
- Style the timer with a dark or light color theme to match the design.
- Localise or rename the Days/Hours/Minutes/Seconds headings per instance.
- Add an optional heading/title above the countdown with a configurable wrapper tag (h1–h5 or none).
- Add optional descriptive text under the title.
- Apply EPT design options (margins, padding, borders) around the countdown.
- Set a background color, image (cover/contain/parallax) or video behind the countdown.
- Render the countdown edge-to-edge or constrained to a container width.
- Reuse the same countdown paragraph across multiple pages via Paragraphs.
- Combine with other EPT paragraph types on one page-building layout.
- Drive the target date/timezone from the datetime field's stored value.
- Place a countdown inside Layout Builder where Paragraphs fields are exposed.
- Provide editors a no-code countdown widget instead of custom JS.
- Confirm the target date and site timezone match your intended deadline.
