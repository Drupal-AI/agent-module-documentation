# TEVIS — manual setup guide

**TEVIS** (`tevis`) connects a Drupal site to the external VOIS|TEVIS
reservation service from Kommunix GmbH and displays upcoming appointment
availability from your TEVIS instance. Its main job is to show the next
available appointment slots for each location you have configured, so a visitor
can get straight into the booking process without first having to work out which
office is responsible for their particular concern.

The module models each TEVIS backend as a small configuration entity — a "TEVIS
server" — that holds the API endpoint, an API key, and connect/request
timeouts. A client factory builds a reservation client from the underlying
`Tevis\ReservationApi` library using Drupal's standard Guzzle HTTP client (TLS
verification is left at core's secure defaults), and an availability service
fetches and caches slot data so the same lookups are not re-requested on every
page load. You can register several servers, which is handy for keeping, say, a
test endpoint separate from production, and each can be enabled or disabled from
the admin list. The main way you surface the data is a block plugin that shows
the next appointment availabilities per location.

TEVIS runs on Drupal 10, 11 and 12. It depends on the `krzn/tevis-sdk` client
library, which Composer downloads for you automatically. All administration is
restricted to the `administer tevis` permission, and the enable/disable
operations are protected by CSRF tokens; the module only *reads* availability
from TEVIS and does not expose any public endpoint that changes data.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its SDK
   library) with Composer and enable it.
2. [Configuration](configuration/index.md) — create a TEVIS server and place the
   availability block.

## Where it lives in the admin menu

TEVIS servers are managed at **Configuration → Web services → TEVIS**
(`/admin/config/services/tevis`), reachable by users with the `administer tevis`
permission. That page lists your servers and lets you add, edit, enable, disable
or delete them.
