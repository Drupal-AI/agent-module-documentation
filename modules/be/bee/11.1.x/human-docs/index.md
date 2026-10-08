# BEE: Bookable Entities Everywhere — manual setup guide

**BEE — Bookable Entities Everywhere** (`bee`) turns ordinary Drupal content types
into bookable resources: a room, a piece of equipment, an appointment slot. Mark a
content type as bookable, choose whether its availability is tracked by the day or
by the hour, and editors and visitors get availability tracking, a reservation
flow, and — if you add Drupal Commerce — paid checkout, so a booking becomes an
order.

BEE is built on top of the **BAT** (Booking & Availability Management Tools)
toolkit. BAT is the availability engine, but on its own it is low-level: wiring a
content type to it — events, booking states, a reservation flow — is a lot of
manual work. BEE is the friendlier layer that does that wiring for you, so you get
a reservation experience without assembling the BAT pieces by hand.

Its dependency list is the honest measure of its scope: the BAT booking and event
stack, **Office Hours** for opening times, and three **Commerce** modules for the
paid path. This is therefore a substantial adoption — it becomes the centre of a
booking system, not a small add-on — and it only makes sense on a site where
reservations are the point. It defines permissions (such as *create bee
reservation* and calendar-view permissions), so who may book and who may see
availability are explicit decisions you make.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module and its BAT,
   Office Hours and Commerce dependencies, and enable it.

## Where it lives in the admin menu

BEE does not have a single central settings page. Instead you work with it in a
few places:

- **People → Permissions** — grant *create bee reservation*, *administer bee
  settings* and the calendar-view permissions to the roles that match your booking
  policy.
- On a **content type**, mark it bookable and choose daily or hourly availability.
- If you want paid bookings, configure **Drupal Commerce** (store, product,
  order) so a reservation can become an order.

## How to use it

1. Install and enable BEE together with its dependencies (see
   [Installation](installation/index.md)).
2. Make a content type bookable and pick daily or hourly availability.
3. Set the reservation and calendar permissions to match who should be able to
   book and who should see availability.
4. For paid bookings, wire up Drupal Commerce so a booking turns into an order
   that can be paid for.
5. Optionally enable the **`bee_webform`** submodule to integrate bookings with
   Webform.
