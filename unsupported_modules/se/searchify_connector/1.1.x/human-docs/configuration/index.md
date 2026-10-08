# Configuration

Searchify Connector needs your Searchify API credentials before it can run any
searches. You configure those through the admin interface, and the module keeps
the key server-side so it is never sent to the visitor's browser.

## Enter your API credentials

Open the module's settings form (as a user with permission to administer the
site) and enter the **Searchify API credentials** it asks for. The module is
built to store these securely — it supports an environment-backed / Key-based
credential so that the raw API key does not have to live in exported
configuration. If you manage secrets with the **Key** module, point the setting
at a Key entity rather than pasting the raw value; otherwise supply the key as
the form expects. Save the form.

Once saved, the key stays on the server. The search page and stream endpoint use
it to talk to Searchify on the visitor's behalf, but the credential itself is
never exposed client-side.

## The public endpoints — and why rate-limiting matters

This module deliberately serves search to the public:

- **`/searchify`** — the visitor-facing search page.
- **`/searchify/stream`** — the server-sent-events (SSE) endpoint that streams
  results back.

Both are public by design, because a site search feature has to be reachable by
anonymous visitors. The important operational caveat is cost: every query is
forwarded to the **paid** Searchify API. Without a limit, anonymous or automated
traffic could run up your API usage. Consider putting **rate-limiting** in front
of these routes (at the Drupal, web-server, or CDN layer) to bound how many
queries any one client can make.

## Test it

Visit `/searchify` as a regular visitor, run a query, and confirm results stream
in. If nothing comes back, re-check that the API credentials were entered
correctly and saved.
