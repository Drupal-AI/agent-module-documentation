# Linkchecker Tagger — manual setup guide

**Linkchecker Tagger** (`linkchecker_request_tag`) is a small developer/operations
convenience for sites running the [Link
Checker](https://www.drupal.org/project/linkchecker) module. Link Checker
verifies your content's links by making outbound HTTP requests to each linked
URL. This module tags every one of those requests with a custom header —
`X-origin: DrupalLinkChecker` — so the traffic is easy to recognise on the
receiving side.

That identifying header makes it straightforward to filter Link Checker's
requests out of traffic logs, write firewall rules for it, or otherwise tell
"our own link checker" apart from other visitors and bots. Once the module is
enabled, all future Link Checker requests carry the header the next time the
Link Checker cron task runs.

The module builds on the header support introduced in Link Checker issue
[#3375253](https://www.drupal.org/project/linkchecker/issues/3375253). It has no
content, no permissions, and no access-control role of its own — it only adds a
request header.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable, and
   rebuild caches.

There is **no configuration** to do and **no settings form** — the header is
added automatically once the module is enabled.

## How to use it

There is nothing to click. After you install and enable the module (and rebuild
caches), Link Checker's outbound requests automatically include the
`X-origin: DrupalLinkChecker` header from the next Link Checker cron run onward.
On the receiving end — a traffic log, firewall, or reverse proxy — you can then
match or filter on that header to identify the traffic.
