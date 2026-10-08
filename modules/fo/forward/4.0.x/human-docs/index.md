# Forward — manual setup guide

**Forward** (`forward`) adds an "email this page to a friend" feature to any
entity on your site — nodes, taxonomy terms, or anything else. A visitor fills in
their name and email, one or more recipient addresses, and an optional personal
message; Forward renders the page and emails it to those recipients.

You expose the feature with a **Forward link** or an **inline Forward form** as a
field formatter on the entity's display, and the emails themselves are fully
token-driven — you control the subject, header, footer and confirmation text with
tokens like `[forward:sender-name]` and `[site:name]`. To keep it from being
abused, sends are protected by flood control (a per-hour limit) and a cap on the
number of recipients per send, and every send is logged and aggregated into
forward statistics you can view.

By default the forwarded page is rendered **as the anonymous user**, so the email
can never leak content a visitor wouldn't otherwise be able to see. The module is
also extensible: it fires Rules/Symfony events after a forward, provides tokens
and hooks other modules can hook into, and ships Views for the log and statistics.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the global settings form, the
   permissions, and how to add the Forward link/form to an entity display.

## Where it lives in the admin menu

The global settings form is at **Configuration → User interface → Forward**
(`/admin/config/user-interface/forward`), gated by the restricted *administer
forward* permission. The Forward form itself lives at
`/forward/{entity_type}/{entity}`.

## How to use it

1. Grant the **access forward** permission to the roles who should be able to send
   (commonly both anonymous and authenticated — that's the point of the module).
2. On the entity's **Manage display**, add the **Forward** field to the display
   and choose its formatter: **forward_link** for a "Forward" link or
   **forward_form** for the form embedded inline.
3. Optionally create a **forward** view mode on the entity's Manage display to
   control exactly what gets emailed (otherwise the teaser or full view is used).
4. Tune the email text, recipient cap, and flood limit on the settings form — see
   [Configuration](configuration/index.md).

A visitor then clicks the link (or uses the inline form), fills in the details,
and the page is emailed to their friend.
