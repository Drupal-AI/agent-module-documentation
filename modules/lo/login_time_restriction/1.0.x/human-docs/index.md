# Login Time Restriction — manual setup guide

**Login Time Restriction** (`login_time_restriction`) lets you limit *when* an
individual user is allowed to sign in and browse your site. Each account gets a
date/time‑range field, and when the current time falls outside that window the
module refuses the login — and, if the user is already signed in when the window
closes, it logs them out mid‑session and sends them back to the login page.

The window is enforced entirely on the server, in two places: a validation
handler on the login form blocks a sign‑in attempt made outside the allowed
hours, and an event subscriber re‑checks on every request so an active session
cannot outlive its window. Times are interpreted in **each user's own timezone**
(the one chosen when their account was created), so a "10:00–12:00" window means
10:00–12:00 wherever that person is.

You can run the module in one of two modes: a **per‑day** (time‑only) window that
repeats every day — handy for shift or business hours — or a fixed **date range**,
useful for something like an exam window. Logged‑in users can optionally see a
sticky countdown timer and a pop‑up that warns them a set number of minutes
before they will be logged out. It depends on the
[Time Range](https://www.drupal.org/project/time_range) module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in the
   Time Range dependency, and enable the module.
2. [Configuration](configuration/index.md) — the settings form (mode, warning
   time, sticky timer, messages) and how per‑user access windows are set.

## Where it lives in the admin menu

The module's settings form is at **`/admin/login_time_restriction/settings`** and
requires the **Administer site configuration** permission. The per‑user access
window itself is set on each user's edit form, in a date/time‑range field
(`field_ltr_access_time`) that only users with the **Allow access time
modification** permission can see or change — so ordinary users cannot widen
their own window.

## How to use it

1. Enable the module and open the settings form to turn the feature on and pick a
   mode (per‑day time window or fixed date range).
2. Grant the **Allow access time modification** permission to the role that should
   manage windows (typically administrators or an HR/office‑manager role).
3. Edit a user account and fill in their allowed access time.
4. That user can now only sign in — and stay signed in — during the window you
   set. When the window closes, their session ends and they are redirected to the
   login page with your configured message.
