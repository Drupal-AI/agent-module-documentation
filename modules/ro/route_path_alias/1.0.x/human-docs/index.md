# Route Path Alias — manual setup guide

**Route Path Alias** (`route_path_alias`) lets you add clean, human‑friendly URL
aliases to **complex routes with dynamic parameters** — the kind of paths core's
alias tools and Pathauto don't cover on their own. If you have a route like
`/user/{user}`, you can give it an alias pattern such as `/person/{user}`, and the
module generates the aliased URLs for you.

It goes further than a simple find‑and‑replace in two important ways. First, it is
**fully multilingual**: you can define aliases per language, so the same route can
read differently in each of your site's languages. Second, it supports
**conditions on the dynamic parameters** — for example, for `/node/{nid}` you can
base the alias on the bundle (content type) of the referenced node, creating a
different alias pattern per type.

It works for **all routes**, both core and custom, and is a pure routing/URL
utility — it has no content of its own. Administration is gated by the **administer
route path aliases** permission. The module ships with no pre‑made aliases; you
add your own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add route aliases, per language and
   with parameter conditions.

## Where it lives in the admin menu

The configuration page sits under the URL alias admin at **Configuration → Search
and metadata → URL aliases → Route aliases**
(`/admin/config/search/path/route-aliases`).
