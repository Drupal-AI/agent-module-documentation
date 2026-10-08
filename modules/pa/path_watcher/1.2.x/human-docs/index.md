# Path Watcher — manual setup guide

**Path Watcher** (`path_watcher`) records which paths on your site get visited and
lets you analyse those page‑view statistics — a lightweight, self‑hosted
alternative to a full analytics platform when all you need is a sense of which
pages are being looked at. It is built to be inexpensive at request time: records
are written during Drupal's `KernelEvents::TERMINATE` phase, *after* the response
has been sent, so tracking does not slow page loads. By design it does **not**
store IP addresses or User‑Agent strings, and it's intended mainly for authorised
(logged‑in) requests.

A settings form lets you filter what gets recorded, and the module ships a
**block** you can place — typically at the bottom of the page — to display visit
counts.

A note on privacy: even without IPs or User‑Agents, recording browsing activity
can constitute personal data in many jurisdictions, especially when it can be
associated with logged‑in users or sessions. Record only what you need, disclose
it in your privacy policy as appropriate, and restrict the statistics to trusted
users via the module's permission. Path Watcher has no access‑control role beyond
that permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the filtering settings, the visits
   block, and the permission that gates the statistics.

## Where it lives in the admin menu

After installation, configure filtering for visit records at **Configuration →
System → Path Watcher** (`/admin/config/system/path-watcher`). The visits block is
placed from **Structure → Block layout** (`/admin/structure/block`).
