# Commerce Time Slots — manual setup guide

**Commerce Time Slots** (`commerce_timeslots`) adds **date and time‑slot
selection** to Drupal Commerce checkout, so customers can book a delivery or
pickup window as part of placing their order. Crucially, it manages **capacity**:
each slot has a maximum number of bookings, so once a window fills up it closes and
customers can no longer choose it — preventing you from overbooking a fulfilment
window.

It's built for stores that deliver or fulfil on scheduled windows — grocery, food,
logistics — where you must cap how many orders land in each slot. You can define
reusable time slots (for example 09:00–11:00), group them into day templates,
override normal days with "desired" days for holidays or special hours, and switch
between different slot configurations as needs change. Each customer's chosen
window is stored as a **booking**, which staff can review from an admin booking
page, and the slot choice is attached to the order's information in the "Other"
section.

The module defines four configuration/content entities — **time slot**, **time
slot day**, **day capacity**, and **booking** — and ships granular permissions so
you can restrict who manages each. It depends on **Commerce**, **Commerce
Shipping**, the **jQuery UI Datepicker** module (for the date picker), and core's
**Datetime Range**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — define slots, days, capacities, and
   the checkout settings, plus the permissions to grant.

## Where it lives in the admin menu

- **Time slots:** `/admin/commerce/timeslots`
- **Time slot days:** `/admin/commerce/timeslots/days`
- **Day capacities:** `/admin/commerce/timeslots/day-capacities`
- **Bookings:** `/admin/commerce/timeslots/booking`
- **Settings:** **Commerce → Configuration → Time slots — Settings**
  (`/admin/commerce/config/timeslots`, route
  `commerce_timeslots.timeslot_settings`)

See [Configuration](configuration/index.md) for how these fit together.
