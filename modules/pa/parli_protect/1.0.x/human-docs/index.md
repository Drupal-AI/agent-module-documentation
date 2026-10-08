# Parliament Protect — manual setup guide

**Parliament Protect** (`parli_protect`) is a niche, tongue‑in‑cheek IP‑based
access‑control module. Out of the box it blocks visitors coming from the UK
Parliament's known IP address ranges: instead of the content they requested, they
are redirected either to a satirical form (which, by design, saves nothing when
submitted) or to a custom title and message of your choosing. Every blocked
attempt is logged, and the module keeps a count of how many times each configured
range has tried to visit.

Although the module ships aimed at UK Parliament ranges, the IP ranges that
trigger the redirect are **customizable** — so in practice you can use it to block
any single IP address or range and return a themed page in response, rather than
the bare HTTP response you would get from core's Ban module. Set a custom title
and message instead of the joke form, point it at whatever ranges you care about,
and it becomes a small general‑purpose "show these visitors a themed block page"
tool.

It supports Drupal 10 and 11, provides its own permission, and stores its choices
as configuration. Note the maintainer's stated policy: this module was written
without AI assistance and does not welcome AI‑generated contributions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — set the IP ranges, choose the form or
   a custom message, and control logging/debugging.

## How to use it

Enable the module, then open its settings form (see
[Configuration](configuration/index.md)) to decide which IP ranges are blocked and
what those visitors see. Once configured, the block is enforced automatically for
matching visitors on every request, and blocked attempts are recorded so you can
review how often the ranges are hit.
