# Query Auth Params — manual setup guide

**Query Auth Params** (`query_auth_params`) lets you "soft‑gate" individual pages
behind a required URL query parameter. You add a rule for a path — say
`/new-awesome-feature` — together with a parameter name and value, and from then on
the page only shows when the visitor arrives with the matching
`?name=value` on the URL. Anyone who lands on the plain path is redirected away (to
the front page, or to a redirect URL you choose).

This is handy for sharing a work‑in‑progress with a client, a colleague, or a
friend without giving them a user account: you send them one link, such as
`/mathematics?access=secret123`, and only people with that link get in. You can
gate a page **forever**, allow it to be viewed **once** and then redirect, or open
it only **until a chosen date and time**.

One thing to be clear about up front: this is **obscurity‑based gating, not real
access control**. The secret rides in the URL query string, so it shows up in
browser history, `Referer` headers, and proxy/web‑server access logs, and the
module caps the parameter name and value at ten alphanumeric characters each — low
entropy. The underlying route and entity permissions still apply. Use it for casual
gating like soft launches and preview links, and never for protecting genuinely
sensitive content. The module's own documentation says the same: "This is not a
security access module and should not be used as such."

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add and tune the pages you want to
   gate, field by field.

## Where it lives in the admin menu

The settings form sits at **Configuration → Development → Query Auth Params**
(`/admin/config/development/query_auth_params`), and it requires the **Administer
site configuration** permission.
