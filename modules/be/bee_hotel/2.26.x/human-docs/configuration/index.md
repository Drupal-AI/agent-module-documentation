# Configuration

BEE Hotel is configured on its settings page (**`beehotel.admin_settings`**),
reached under the admin menu once the module is enabled. Because BEE Hotel is a
full booking application, configuration spans a few areas rather than a single
form.

## Permissions first

BEE Hotel provides its own permissions, including administration and pricing
controls. Under **People → Permissions** (`/admin/people/permissions`), grant the
admin and pricing permissions only to the roles that should manage the hotel.
These control who can change rooms, availability and rates, so keep them tight.

## The BEE Hotel settings page

Open the BEE Hotel settings page (`beehotel.admin_settings`) to configure the
suite. The main things you set up are:

- **Units (rooms)** — the bookable units guests can reserve.
- **Availability** — when each unit can be booked, built on BAT's availability
  engine.
- **Pricing** — base rates plus seasonal and dynamic pricing. Dynamic pricing is
  driven by the **price-alterator** plugins from the `beehotel_pricealterator` /
  `beehotel_pricealterators` submodules; enable those if you need rates that
  change by season, length of stay, and so on.

## Payment — handled by Commerce

You do not configure payment in BEE Hotel itself. When a booking is placed, BEE
Hotel builds a Commerce order and hands it to **Drupal Commerce**, whose payment
gateways are server-authoritative. Configure your payment method(s) in Commerce as
usual; BEE Hotel relies on Commerce to take and verify payment.

## Before going live — review

- **Public booking routes.** BEE Hotel exposes booking pages to the public.
  Review those routes against your own policy for who can see and start a booking.
- **Keep the stack updated.** BEE Hotel sits on BAT, Commerce and other modules;
  security depends on keeping the whole stack current, not just this module.
- **Try it with the sample hotel.** Enabling `beehotel_samplehotel` (see
  [Installation](../installation/index.md)) gives you a worked example to learn
  the configuration before building your own.
