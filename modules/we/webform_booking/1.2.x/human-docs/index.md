# Webform Booking — manual setup guide

**Webform Booking** (`webform_booking`) adds a booking element to the Webform
module so an ordinary Webform becomes a slot or appointment booking form.
Visitors pick an available day, then an available time slot; the module checks
availability on the server so the same slot can't be double-booked, even if two
people submit at once.

It can also take payment. When you configure PayPal credentials, a booking form
collects a (server-verified) PayPal payment before the submission is accepted —
and the charge is always calculated on the server, so the browser can't tamper
with the amount. Leave the PayPal secret empty and the same form is simply free.
Customers can cancel their own booking through a tokenised link without needing
an account, and staff with the right permission can cancel any booking.

Two optional submodules extend it: **Webform Booking Calendar**
(`webform_booking_calendar`) shows bookings on a FullCalendar block/feed, and
**Webform Booking Price Element** (`webform_booking_price_element`) adds a
title-and-price line-item element you can combine with the booking element to
build multi-service forms. The module also ships a *booking submissions* View
and booking tokens (date, time, number of slots) you can drop into confirmation
emails.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and pick the submodules you need.
2. [Configuration](configuration/index.md) — the global settings form (PayPal,
   currency, country), the three permissions, and how to add the booking element
   to a form.

## Where it lives in the admin menu

The global settings form is at **Configuration → Web services → Webform Booking**
(`/admin/config/services/webform-booking`), gated by the restricted *manage
webform booking* permission. The booking element itself is added from within a
form in the Webform UI (**Add element → Booking**).

## How to use it

1. Create or open a Webform.
2. In the Webform's build screen choose **Add element**, pick **Booking** (in the
   *Booking* category), and configure its opening days, slot length and capacity
   on the element settings — availability rules are stored on the element, there
   is no separate config entity.
3. If you want paid bookings, enter your PayPal credentials on the settings form
   (see [Configuration](configuration/index.md)); otherwise the form stays free.
4. Publish the form. Visitors pick a day and slot; availability is fetched live
   as they choose a date, and enforced again server-side on submit.

You can review bookings through the provided *booking submissions* View, display
them on a calendar with the calendar submodule, and reference booking details in
confirmation emails through the booking tokens.
