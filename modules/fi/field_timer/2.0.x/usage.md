<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Timer provides field formatters for core `datetime` fields that render the stored date as a live counting timer or countdown instead of a static date, using either a lightweight text mode or JavaScript widgets (jQuery Countdown, jQuery Countdown LED, County).

---

The module adds four field formatter plugins, all targeting the core `datetime` field type and configured on an entity's *Manage display* page (stored in `core.entity_view_display.*` components). `field_timer_simple_text` ("Text timer or countdown") extends core's `DateTimeTimeAgoFormatter` and needs no external library; its `type` setting (`auto`/`timer`/`countdown`) decides whether past dates (timer), future dates (countdown), or both (auto) are shown. The three JS formatters render markup carrying a `data-timestamp` and are animated client-side: `field_timer_countdown` ("jQuery Countdown") and `field_timer_countdown_led` ("jQuery Countdown LED") require the jQuery Countdown library (v2.1.0) placed at `libraries/jquery.countdown`, and `field_timer_county` ("County") requires the County library at `libraries/county`. The jQuery Countdown formatter exposes rich settings (format string, layout, compactness, granularity, separator, zero-padding) plus a large per-language translation layer; the LED variant offers a green/blue LED theme and toggles for days/hours/minutes/seconds; County offers animation, speed, colour theme, background and reflection. Config schemas exist for each formatter's settings. There is no admin settings page or configure route — everything is per field, per view mode.

---

- Show an event's start date as a live countdown ("starts in 3 days 04:12:07").
- Show a publication date as an elapsed timer ("running for 2 days") using the text formatter.
- Render a datetime field as an auto timer/countdown that flips based on whether the date is past or future.
- Add a flashy LED-style countdown to a "launch date" field on a landing page.
- Use the County animated widget for a stylised countdown with fade/scroll animation and colour themes.
- Display a sale end date as a jQuery Countdown that ticks down in the browser.
- Configure the text formatter to only show *future* dates as a countdown (`type: countdown`).
- Configure the text formatter to only show *past* dates as a timer (`type: timer`).
- Present a webinar start time counting down in the visitor's browser without page reloads.
- Choose a compact jQuery Countdown display (e.g. "3d 04:12:07") via the compact setting.
- Set the countdown granularity so only the most significant units are shown.
- Localise the jQuery Countdown labels using the module's per-language translation libraries.
- Show only hours/minutes/seconds (hide days) on an LED countdown for short timers.
- Theme an LED countdown green or blue to match a campaign.
- Add a reflection effect and colour theme to a County timer.
- Apply a timer formatter per view mode (teaser vs. full) on the same datetime field.
- Drive a "time since posted" indicator on article teasers.
- Build a "membership expires in" countdown on a user profile datetime field.
- Show a deadline countdown on a task/deadline datetime field.
- Present a "time on site since" running timer for an account creation date.
- Give a media or taxonomy datetime field a countdown display through its Manage display page.
- Swap a plain date display for a countdown without changing stored data or the field type.
- Show a "coming soon" countdown that disappears (auto) once the date passes.
- Configure zero-padding and a custom time separator on a jQuery Countdown timer.
