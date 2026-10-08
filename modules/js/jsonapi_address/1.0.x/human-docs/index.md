# JSON:API Address — manual setup guide

**JSON:API Address** (`jsonapi_address`) exposes the reference data from the
[Address](https://www.drupal.org/project/address) module — the list of countries
and their subdivisions (states, provinces, regions) — through JSON:API, along
with postal-code validation. On a decoupled or headless site, that lets your
front end populate address forms and validate what people type against exactly
the same data Drupal itself uses.

It works by adding a handful of read-only JSON:API endpoints. There is nothing to
click through and no settings form: once the module is enabled, the endpoints
exist and your front end simply calls them. The endpoints are:

- **All countries** — `/jsonapi/address/country`
- **One country** — `/jsonapi/address/country/{country_code}`
- **A country's subdivisions** — `/jsonapi/address/country/{country_code}/subdivision`
- **One subdivision** — `/jsonapi/address/country/{country_code}/subdivision/{subdivision_code}`

Access is gated by two dedicated permissions — one for the address data and one
for postal-code validation (see below) — so you decide which roles may call the
endpoints. As with any API surface, this exposes data to whoever holds those
permissions, so grant them deliberately.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Address /
   JSON:API Resources dependencies, then enable it.

There is **no configuration page** — the module needs no configuration. You only
grant permissions (below) and call the endpoints.

## Where it lives in the admin menu

The module adds no admin page of its own. The one thing you'll do in the UI is
grant its permissions at **People → Permissions**
(`/admin/people/permissions`):

- **`jsonapi_address access address data`** — lets a role read the country and
  subdivision endpoints.
- **`jsonapi_address access postal code validation`** — lets a role use
  postal-code validation.

Grant these to the roles (or the API consumer's role) that need them, then have
your front end call the endpoints listed above.
