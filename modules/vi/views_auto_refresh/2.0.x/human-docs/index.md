# Views Auto Refresh — manual setup guide

**Views Auto Refresh** (`views_auto_refresh`) makes an Ajax‑enabled View update
itself without a full page reload. Add it to a View and the results re‑run on a
timer — every few seconds, say — so a dashboard of recent orders, a moderation
queue, a "latest activity" feed, or a live scoreboard stays current on screen.
You can also give visitors buttons to start/stop the refreshing themselves or to
reload once on demand.

It works by adding two **Views area handlers** you drop into a View's header or
footer: **Global: Auto Refresh** (the main one, where you set the interval and all
the options) and **Global: Auto Refresh (secondary)** (an extra spot to place the
control buttons somewhere else, like the footer). The handler attaches a small
JavaScript library that re‑triggers the View's own Ajax refresh on your chosen
interval. There is no global admin settings page — everything is configured on the
View itself, per display.

Two things are non‑negotiable for it to work: the View must have **Use Ajax**
turned on, and its **caching** must be off (otherwise it would just serve stale
results). The only dependency is core's **Views** module, and there are no
permissions to grant.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the JavaScript
`RefreshView` trigger for custom code — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

(There's no separate configuration page — this module has no admin settings form.
You configure it on each View, described below.)

## Where it lives in the admin menu

There is no admin settings page. You configure everything inside the Views UI at
**Structure → Views** when editing a specific View.

## How to set it up

1. Edit the View you want to auto‑refresh.
2. Add a **header** (or footer) of type **Global: Auto Refresh**.
3. Set the **Interval** in *milliseconds* (default `50000`, i.e. 50 seconds) and
   toggle any of the options below.
4. In the View's **Advanced → Other** settings, set **Use Ajax = Yes** and
   **Caching = None**. Both are required.
5. Save. The View now refreshes on the timer.

If you want the toggle / "Refresh now" buttons rendered somewhere different from
the primary area, add **Global: Auto Refresh (secondary)** as a second area (for
example in the footer).

## The options on the primary area

- **Interval** — polling interval in milliseconds. Must be a number.
- **Auto refresh toggle button** — shows an on/off button so visitors can start
  and stop the auto‑refresh themselves, with configurable **enable**/**disable**
  labels.
- **Refresh now button** — a one‑shot button that reloads the View immediately,
  with a configurable label.
- **Auto start refresh** — start refreshing as soon as the page loads. (Note: if
  there is no toggle button, auto‑start is forced on regardless.)
- **Stop on pagination** — pause the refresh when the visitor has navigated past
  page 1 of a paginated View, so they aren't yanked back.
- **Restore focus after refresh** — return keyboard focus to where it was after a
  refresh, so keyboard and screen‑reader users aren't disrupted (accessibility).
- **Stop on focused view content** — pause refreshing while the user's focus is
  inside the View's content (also for keyboard navigation).
- **Disable ajax scroll top** — stop the default Views "scroll to top" jump on
  each background refresh.
- **Disable ajax throbber** — hide the loading spinner during background
  refreshes.

Button labels allow a single `<span>` (handy for a CSS icon); everything else in
a label is stripped for safety. The secondary area only offers the two button
toggles — the interval and behaviour always come from the primary area.

You can also trigger a refresh from your own JavaScript by firing a `RefreshView`
event on the View's DOM element — see the [`agent/`](../agent/start.md) docs for
the exact snippet.
