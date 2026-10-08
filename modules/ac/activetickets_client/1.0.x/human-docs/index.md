# ActiveTickets Client — manual setup guide

**ActiveTickets Client** (`activetickets_client`) is a client interface to the
**ActiveTickets** ticketing and events platform. It connects Drupal to
ActiveTickets so the site can fetch and manage events and ticketing data — for
example showing upcoming events on the site or working with booking information.

It is a straightforward integration module in the "ActiveTickets" package. You
install it when your site needs to talk to ActiveTickets, and it does the work of
calling the ActiveTickets API on Drupal's behalf.

Because it talks to an external ticketing service, two data-handling points
matter. It authenticates to the ActiveTickets API with credentials, so store
those as secrets (environment variables or a Key entity) and connect over HTTPS.
And it may exchange customer and booking data — which is personal data — so
handle it in line with your privacy obligations. The module has no
access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — provide the ActiveTickets
   credentials, stored as secrets, over HTTPS.

## Where it lives in the admin menu

After enabling, connect the module to ActiveTickets with your API credentials
(see [Configuration](configuration/index.md)). It then acts as the client that
fetches and manages events and ticketing data for the site.
