# Booking Scheduler — manual setup guide

**Booking Scheduler** (`booking_scheduler`) provides generic booking
functionality on top of Drupal content. It models bookable items, tracks their
availability, and schedules bookings — using Drupal's content moderation and the
contributed Scheduler module to move bookings through their states over time. It
suits reservations, appointments, and resource‑booking scenarios where you do
not need a full commerce/checkout stack.

Rather than being a single settings screen, it is a **content‑modelling tool**:
it builds on a stack of core modules (`content_moderation`, `datetime`, `field`,
`menu_ui`, `node`, `options`, `path`, `taxonomy`, `text`, `workflows`) plus the
contributed `scheduler` module, and layers booking behavior and its own
permissions on top. It supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in
   Scheduler and several core modules) and enable it.

## Where it lives in the admin menu

The module does not add a single dedicated settings dashboard. You work with it
through the standard Drupal admin areas it builds on:

- **Content** (`/admin/content`) — create and manage bookings/bookable items.
- **People → Permissions** (`/admin/people/permissions`) — the module provides
  its own permissions; grant them to the roles that should create or manage
  bookings.
- **Configuration → Workflow** — the content‑moderation workflow and the
  Scheduler settings that drive booking states over time.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)); it
   brings in the Scheduler module and the core modules it relies on.
2. At **People → Permissions**, grant the module's booking permissions to the
   appropriate roles.
3. Create bookings/bookable content under **Content**, using the date/time and
   availability behavior the module provides.
4. Bookings move through their moderation states with the help of content
   moderation and Scheduler — review the workflow and scheduling settings so the
   states advance the way you expect.

The bundled agent docs for this module are brief, so confirm the exact content
types, fields, and workflow it installs on your own site after enabling it.
