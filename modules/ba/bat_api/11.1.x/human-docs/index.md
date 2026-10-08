# BAT API — manual setup guide

**Booking and Availability Management API** (`bat_api`) puts the data from
**BAT** — the Booking and Availability Management Toolkit — behind a REST API.
BAT models the hard part of any reservation system: what is available when,
across units, with overlapping events and states. Normally that data is consumed
inside Drupal; this module exposes it over REST so something *outside* Drupal — a
mobile app, a React booking widget, another service — can read and work with
availability and events without rendering Drupal pages.

It only makes sense on a site already running BAT. It depends on the BAT stack
(`bat_event`, `bat_fullcalendar`) and on **REST UI** (`restui`), which is the
admin tool you use to switch the REST resources on and set how they are secured.

Because this is booking data, security is not an afterthought — it is the main
configuration decision. Availability data drives real bookings, so an
unauthenticated or over‑permissive API is a way for a caller to read your
availability or perturb it. When you enable the REST resources you must set their
permissions and authentication deliberately. That is covered in
[Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   (needs a working BAT site).
2. [Configuration](configuration/index.md) — turning the REST resources on and,
   crucially, locking down their permissions and authentication.

## Where it lives in the admin menu

The module has no settings page of its own — you configure the REST resources it
exposes through **REST UI**, at **Configuration → Web services → REST**
(`/admin/config/services/rest`). See [Configuration](configuration/index.md).
