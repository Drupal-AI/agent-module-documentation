<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Time Slots adds **date + time-slot selection** to Drupal Commerce checkout, letting customers book a
delivery or pickup window. It manages per-day slots and their **capacity** so a slot fills up and closes.

Use it for stores that deliver or fulfil on scheduled windows (grocery, food, logistics) where you must cap how
many orders land in each slot. It integrates with Commerce Shipping and uses jQuery UI datepicker plus a
datetime_range field for the booking UI.
---
- Requires `commerce`, `commerce_shipping`, `jquery_ui_datepicker`, and core `datetime_range`.
- Enable with `ddev drush en commerce_timeslots`; the datepicker library must be present.
- Defines four config entities: **time slot**, **time slot day**, **day capacity**, and **booking**.
- Manage them under `/admin/commerce/timeslots` (settings at `/admin/commerce/config/timeslots`).
- Ships granular permissions (`administer commerce timeslot entity`, `... day`, `... day capacity`,
  `administer commerce timeslot bookings`, plus view/add/edit/delete per entity).
- The availability AJAX endpoint (`/ajax/commerce-timeslots/get-availability/...`) is gated by `access content`
  and returns only slot-availability markup (read-only).
---
- Offer customers selectable delivery/pickup windows at checkout.
- Define reusable time slots (e.g. 09:00–11:00).
- Group slots into day templates.
- Set a capacity (max bookings) per slot/day.
- Automatically hide or disable full slots.
- Track each customer's chosen slot as a booking entity.
- Query real-time availability via AJAX as the customer picks a date.
- Restrict booking management to staff via granular permissions.
- Integrate the slot choice with Commerce Shipping.
- Use the jQuery UI datepicker for date selection.
- Report on bookings per slot from the admin collection.
- Delete or edit bookings administratively.
- Model different capacities for different weekdays.
- Prevent overbooking of a fulfilment window.
- Export slot/day/capacity definitions as configuration.
- Localize availability output per current language (cache-keyed by langcode).
