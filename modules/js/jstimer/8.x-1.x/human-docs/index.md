# JS Timer — manual setup guide

**JS Timer** (`jstimer`) provides a JavaScript timer API plus ready-made timer
widgets for showing time that updates live in the browser. It is the oldest of the
Drupal "jQuery countdown timer" modules, and it is useful whenever you want a
moving clock, a countdown to a deadline, or any small widget that refreshes every
second on the page.

Under the hood it hooks HTML elements to JavaScript widget objects and drives them
all from a single event loop, so you can run as many timers as you need on one page
without a performance penalty. It ships with three widgets: a **count-down timer**
(`jst_timer`), a **count-up timer**, and a **live clock** (`jst_clock`). It uses
jQuery and requires no libraries outside of Drupal, and it has no dependencies
beyond core's Field module. It is purely a front-end display utility with no
security surface.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

This module has **no dedicated admin settings page**. Its behaviour is applied
where you place the timer widgets, described under "How to use it" below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Use one of the provided widgets — the live clock (`jst_clock`), the count-down
   timer (`jst_timer`), or the count-up timer — to display running time in your
   markup, or build on the timer API to attach your own updating widget to an HTML
   element.
3. **Check the timezone** — a clock or countdown is only useful if it shows the
   right time, so confirm the time it displays matches your intent (for example the
   site's timezone versus the visitor's) before relying on it in production.
