# BEE Hotel — manual setup guide

**BEE Hotel** (`bee_hotel`) is a hotel and bed-and-breakfast **booking suite** for
Drupal. It builds on BAT (Booking & Availability Management), the BEE module, and
**Drupal Commerce** to manage bookable units (rooms), their availability,
seasonal and dynamic pricing, guest messages, iCal feeds, and turning a booking
into a Commerce order that can be paid for.

Where the plain BEE module makes a content type bookable, BEE Hotel is the
opinionated, hotel-shaped application on top of that stack — it knows about rooms,
rates and stays. It ships a large set of submodules for optional features:
add-to-cart, events, a "happening today" view, iCal, the price-alterator plugin
system that drives dynamic pricing, a sample hotel for getting started, and
several utility and upgrade helpers.

On the money side, **payment is delegated to Drupal Commerce**: BEE Hotel builds
the orders and order items and hands them to Commerce's payment gateways, which
are server-authoritative. That means the module does not implement its own
payment-callback trust boundary — the security of payment rests on Commerce, as it
should. Because it sits on a large stack (BAT, Commerce, and more) and exposes
public booking pages, treat it as a substantial application: keep the whole stack
updated, review the public booking routes against your policy, and lock down the
admin and pricing permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its BAT, BEE and
   Commerce dependencies, enable it, and choose the submodules you need.
2. [Configuration](configuration/index.md) — set up units, availability and
   pricing on the BEE Hotel settings page.

## Where it lives in the admin menu

BEE Hotel provides its own permissions and is configured on its settings page
(**`beehotel.admin_settings`**). Grant its admin and pricing permissions under
**People → Permissions** to the roles that should manage the hotel, and use the
settings page to configure units, availability and pricing — see
[Configuration](configuration/index.md).
