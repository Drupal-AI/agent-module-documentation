# Bizzabo API connector — manual setup guide

**Bizzabo API connector** (`bizzabo_connector`) pulls events from the
[Bizzabo](https://www.bizzabo.com/) events API and renders them as a listing on
your Drupal site. You give it the API base URL and a bearer authentication key,
and it fetches the endpoint, paginates the returned events, and displays them
through its own theme template — showing details such as start and end dates,
venue, and city/state/timezone.

Use it when you run events in Bizzabo and want an automatically populated events
listing on your Drupal site without hand-copying each event.

The bearer authentication key you enter is stored as a **plain-text configuration
value**. Treat it as a secret: prefer supplying it from an environment variable
(for example with DDEV's `ddev dotenv set` and reading it via `getenv()` or a Key
entity) rather than committing the raw key into exported configuration.

**Please read this before you launch.** Two of the module's routes are declared
open to everyone (`_access: "TRUE"`): the events-fetch route
(`/bizabo/fetch/events`) and the test-connection route (`/admin/config/api/param`).
That means the fetched Bizzabo event listing is reachable **anonymously** by any
visitor. If your event data is meant to be public that may be fine — but decide
deliberately, and review these routes' access before going live.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the API base URL and bearer key,
   test the connection, and surface the events listing.

## Where it lives in the admin menu

The configuration forms live under **Configuration** — the base URL and key form is
at `/admin/config/eventapi/baseUrl` and the connection test at
`/admin/config/test_connection`, both requiring the **Administer site
configuration** permission. The rendered events listing is served at
`/bizabo/fetch/events`.
