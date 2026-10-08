# Konfhub Integration — manual setup guide

**Konfhub Integration** (`konfhub`) connects your Drupal site to
[KonfHub](https://konfhub.com/), an event‑management and ticketing platform. It
makes ticket‑booking data easy to handle by providing a **webhook listener** for
KonfHub POST events: when someone books a ticket, KonfHub sends the details to
your site, and the module stores and manages that ticket information in Drupal.
It also integrates with **Views**, so you can build custom reports and listings of
the ticket data you receive.

The typical use is keeping event registrations and attendees in sync between
KonfHub and Drupal without manual data entry — so your Drupal site always reflects
who has booked.

The module talks to KonfHub using **API credentials** you configure. Those
credentials are secrets: store them in an environment variable rather than
committing them to configuration (see [Configuration](configuration/index.md)).
Because ticket data arrives over an inbound webhook, treat the endpoint as you
would any external integration point — make sure it's reachable over HTTPS and
that only KonfHub is configured to post to it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your KonfHub credentials
   securely and connect the webhook.

## Where it lives in the admin menu

Once enabled, the module exposes a settings form (under **Configuration**) where
you enter your KonfHub API credentials. The ticket data it receives can be
surfaced anywhere through **Views** (**Structure → Views**).

## How to use it

Configure your KonfHub credentials in Drupal, then register your site's webhook
endpoint in KonfHub so booking events are posted to it. As tickets are booked, the
details flow into Drupal automatically; build a View over that data to create the
attendee lists or reports you need.
