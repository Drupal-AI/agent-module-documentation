jQuery Countdown Timer provides a single configurable block that renders a live countdown (days/hours/minutes/seconds) to a target date using jQuery and CSS only — no images.

---

The module registers one block plugin, `jquery_countdown_timer` (admin label "Countdown Timer"),
via `src/Plugin/Block/JqueryCountdownTimerBlock.php`. Its block settings form exposes just two
fields: a **Timer date** (`datetime`, year range 2016–+50, defaulting to "tomorrow") and a
**Timer font size** (a number, default 28). On save the datetime is stored as `Y-m-d H:i:s` and
the font size as an integer in the block's configuration (schema `block.settings.countdown_config`).
The block's `build()` emits two empty `<div>` containers (`#jquery-countdown-timer` and
`#jquery-countdown-timer-note`), attaches the `jquery_countdown_timer/countdown.timer` library
(jQuery + Drupal + drupalSettings + once, plus the module's CSS/JS), and passes the target as a
Unix timestamp (`strtotime()` of the stored datetime) and the font size through
`drupalSettings.countdown`. The bundled JavaScript reads those settings and updates the countdown
in the browser. There is no global config page, no permissions, and no Drush — you place and
configure it entirely through Block layout (`/admin/structure/block`).

---

- Display a live countdown to a product launch or event on any region of the site.
- Add a "sale ends in…" timer to a landing page via Block layout.
- Show a coming-soon / maintenance countdown without custom theming.
- Place the countdown block in a sidebar, header, or hero region.
- Set an exact target date and time (to the second) for the countdown.
- Adjust the countdown's font size to fit the placement.
- Reuse the same block plugin in multiple placements with different target dates.
- Restrict where the timer appears using standard block visibility conditions.
- Provide a lightweight, image-free countdown that depends only on jQuery and CSS.
- Drive urgency for registrations or ticket sales with a visible deadline.
- Count down to a webinar or livestream start time.
- Show a New Year / holiday countdown.
- Add a deadline timer to a campaign page managed by non-developers.
- Combine with other blocks in a region since it renders as a self-contained widget.
- Change the target date later by editing the block configuration, no code changes.
