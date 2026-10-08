# Planyo Reservation System — manual setup guide

**Planyo Reservation System** (`planyo`) embeds the [Planyo.com](https://www.planyo.com/)
online reservation and booking service into your Drupal site. Rather than building
booking logic in Drupal, you let Planyo handle the hard parts — availability
calendars, reservations, and payments — and this module renders the Planyo widget on
your pages so visitors can book right there. It is a good fit for rentals,
appointments, classes, equipment hire, and similar reservation-driven sites.

Because the reservation flow runs on **Planyo's** side, Planyo is the authoritative
system for bookings and any payments; Drupal's role is to present the widget and point
it at your Planyo account. You configure your Planyo site and API details in the
module, and it takes care of embedding.

A couple of important notes. The connection uses a **Planyo API key** — treat it as a
secret: store it in an environment variable and reference it via the Key module rather
than committing it. And because booking and customer details are processed by Planyo,
a third-party service, this is a data-processing/privacy consideration: use HTTPS,
disclose the data sharing in your privacy policy, and obtain consent where required.
The module has no access-control role of its own.

> **Naming:** the project's Composer/machine name is `planyo_reservation_system`, but
> the enabled module's machine name is `planyo`. Use each in the right place (see
> [Installation](installation/index.md)).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — connect your Planyo account and store the
   API key securely.

## How to use it

Once your Planyo site and API details are configured (see
[Configuration](configuration/index.md)), the module renders the Planyo reservation
widget so visitors can check availability and book. The booking, calendar, and payment
handling all take place within Planyo; your site simply displays the embedded flow.
